//
//  SceneDelegate.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/5.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
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
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        // 加载tabbar样式
        let tabBarController = setupTabBarStyle(delegate: self as? UITabBarControllerDelegate)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

