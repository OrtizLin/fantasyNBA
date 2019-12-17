//
//  SettingsViewController.swift
//  apitesting
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var settingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBackBotton()
        settingButton.themeButtonStyle(isSolid: false)
        tokenTextField.text = UserDefaults.standard[UDName.token] ?? ""
        seasonTextField.text = "2019"
    }
    @IBAction func settingButtonPressed(_ sender: Any) {
       UserDefaults.standard[UDName.token] = tokenTextField.text ?? ""
       UserDefaults.standard[UDName.season] = seasonTextField.text ?? "2019"
       UserDefaults.standard[UDName.updateTimeStamp] = 0
       self.view.makeToast("設定成功")
    }
    
}
