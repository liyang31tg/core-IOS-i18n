//
//   HomeViewController.swift
//  LocalSwitchLanguage
//
//  Created by iomeeting on 15/12/22.
//  Copyright © 2015年 liyang. All rights reserved.
//

import Foundation
import UIKit
class HomeViewController: UIViewController {
    
    @IBAction func swichLangeUageAction(sender: AnyObject) {
        print("切换语言")
        Languager.standardLanguager().currentLanguage = Languager.standardLanguager().currentLanguage == "zh-Hans" ? "en" :"zh-Hans"
        let mainSb = UIStoryboard(name: "Main", bundle: nil)
        let rootViewC = mainSb.instantiateInitialViewController() as! UITabBarController
        rootViewC.selectedIndex = 0  //回到设置页面
        UIApplication.sharedApplication().delegate!.window!!.rootViewController = rootViewC
    }
}
