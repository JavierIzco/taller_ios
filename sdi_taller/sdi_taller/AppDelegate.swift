//
//  AppDelegate.swift
//  sdi_taller
//
//  Created by usuario on 24/11/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

   

    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        let rootViewController: LoginViewController = {
            return UIStoryboard.viewController(identifier: "LoginViewController") as! LoginViewController
        }()
        
    }
}

extension UIStoryboard {
    class func viewController(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
