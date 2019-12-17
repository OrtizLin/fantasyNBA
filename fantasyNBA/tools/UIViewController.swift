//
//  UIViewController.swift
//  apitesting
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

extension UIViewController {
    func setNavBackBotton() {
        // Call Func Page
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"),
                                                           style: .plain, target: self, action: #selector(navBackAction))
        // Next Nav Page
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func navBackAction() {
        dismiss(animated: true, completion: nil)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
