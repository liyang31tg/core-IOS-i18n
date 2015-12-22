//
//  mainTabbarViewVC.swift
//  LocalSwitchLanguage
//
//  Created by iomeeting on 15/12/22.
//  Copyright © 2015年 liyang. All rights reserved.
//

import Foundation
import UIKit

class mainTabbarViewVC: UITabBarController {
    @IBOutlet weak var mainTabbar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTabbar.tintColor = UIColor(red: 255.0/255.0, green: 136.0/255.0, blue: 3.0/255.0, alpha: 1.0)//设置按钮选中颜色，在xib里面设置无效，不知道为什么
    }

}