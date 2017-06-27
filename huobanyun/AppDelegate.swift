//
//  AppDelegate.swift
//  huobanyun
//
//  Created by AirBook on 2017/6/13.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit
import LeanCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //leanclou注册
        LeanCloud.initialize(applicationID: "tVf8rAWQg3KOMKoPVI1uwJKW-gzGzoHsz", applicationKey: "zqT7ao17zryNE2JPO9wIUNi4")
        //判断用户是否第一次使用app
        let userdefaults = UserDefaults.standard
        let bool = userdefaults.bool(forKey: "first")
        if bool{
            //真为不是第一次登陆
           // 判断用户是否已经登陆
                    let name = userdefaults.object(forKey: "name")
                    let sb = UIStoryboard(name: "loginanderegisiter", bundle: Bundle.main)
                    if name == nil {
                        let vc = sb.instantiateInitialViewController()
                       self.window?.rootViewController = vc
                    }
        }else{
            //否为第一次登陆
            let vc2 = guideViewController()
            self.window?.rootViewController = vc2
            userdefaults.set(true, forKey: "first")
        }
        return true
    }



}

