//
//  SceneDelegate.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var applicationCoordintor: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            applicationCoordintor = ApplicationCoordinator(window: window)
            applicationCoordintor?.start()
        }
    }
}

