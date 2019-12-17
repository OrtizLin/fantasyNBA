//
//  AppManager.swift
//  apitesting
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Toast_Swift

protocol Accessible {
    func start()
}

class AppManager: Accessible {
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = .white
        // Back indicator image / Button titles / Button images
        navigationBarAppearance.barTintColor = UIColor(red: 0, green: 0.25, blue: 0.53, alpha: 1)
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.window.rootViewController = mainVC
    }

}
