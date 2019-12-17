//
//  GlobalFunc.swift
//  apitesting
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

func instantiate<T: UIViewController>(storyboard: StoryboardName, viewController: ViewControllerID) -> T {
    let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: viewController.rawValue) as! T
    return viewController
}

enum StoryboardName: String {
    case main = "Main"
    case sideMenu = "SideMenu"
}


enum ViewControllerID: String {
    case main = "MainViewController"
    case filter = "StatsFilterViewController"
    case simulator = "SimulatorViewController"
    case settings = "SettingsViewController"
}
