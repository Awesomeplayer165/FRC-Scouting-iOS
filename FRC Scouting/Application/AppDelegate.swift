//
//  AppDelegate.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
         
    static var orientationLock = UIInterfaceOrientationMask.all // By default you want all your views to rotate freely
    
    static func setOrientationLock(_ interfaceOrientation: UIInterfaceOrientation, orientationMask: UIInterfaceOrientationMask) {
        UIDevice.current.setValue(interfaceOrientation.rawValue, forKey: "orientation") // Forcing the rotation to portrait
        AppDelegate.orientationLock = orientationMask // And making sure it stays that way
    }
 
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
