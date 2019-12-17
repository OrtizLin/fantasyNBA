//
//  SideMenuViewController.swift
//  apitesting
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController {

    var items = ["數據篩選", "模擬選秀", "系統設定"]
    var icons = [#imageLiteral(resourceName: "file"),#imageLiteral(resourceName: "file"),#imageLiteral(resourceName: "settings")]
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSideMenu()
    }
    
    func configureSideMenu() {
        
        if let _ = UserDefaults.standard[UDName.token] {
            tokenLabel.text = "密鑰設定：設定完成"
        } else {
            tokenLabel.text = "密鑰設定：設定失敗"
        }
        
        if let season = UserDefaults.standard[UDName.season] {
            seasonLabel.text = "球季：\(season)"
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuAnimationOptions = .curveEaseInOut
        SideMenuManager.default.menuAnimationFadeStrength = 0
        SideMenuManager.default.menuWidth = screenWidth * 0.84
    }
}

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
        cell.itemLabel.text = items[indexPath.row]
        cell.iconImageView.image = icons[indexPath.row]
        return cell
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var navigationViewController = instantiate(storyboard: .sideMenu, viewController: .filter) as! UINavigationController
        
        switch indexPath.row {
        case 0: navigationViewController = instantiate(storyboard: .sideMenu, viewController: .filter) as! UINavigationController
        case 1: navigationViewController = instantiate(storyboard: .sideMenu, viewController: .simulator) as! UINavigationController
        case 2: navigationViewController = instantiate(storyboard: .sideMenu, viewController: .settings) as! UINavigationController
        default: break
        }
        present(navigationViewController, animated: true, completion: nil)
    }
}
