//
//  AppDelegate.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/5.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13, *) {
        } else {
            // 加载tabbar样式
            let tabBarController = setupTabBarStyle(delegate: self as? UITabBarControllerDelegate)
            window?.backgroundColor = UIColor.white
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    // 加载标签栏tabBar
    func setupTabBarStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        
        let home = HomeController()
        let listen = ListenController()
        let play = PlayController()
        let find = FindController()
        let mine = MineController()
        
        home.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_selected"))
        listen.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "我听", image: UIImage(named: "listen"), selectedImage: UIImage(named: "listen_selected"))
        play.tabBarItem = ESTabBarItem.init(IrregularityContentView(), title: nil, image: UIImage(named: "play_selected"), selectedImage: UIImage(named: "play_selected"))
        find.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "发现", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_selected"))
        mine.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "我的", image: UIImage(named: "mine"), selectedImage: UIImage(named: "mine_selected"))
        let homeNav = NavigationController.init(rootViewController: home)
        let listenNav = NavigationController.init(rootViewController: listen)
        let playNav = NavigationController.init(rootViewController: play)
        let findNav = NavigationController.init(rootViewController: find)
        let mineNav = NavigationController.init(rootViewController: mine)
        
        tabBarController.viewControllers = [homeNav, listenNav, playNav, findNav, mineNav]
        return tabBarController
    }

}


@available(iOS 13.0, *)
extension AppDelegate {
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
