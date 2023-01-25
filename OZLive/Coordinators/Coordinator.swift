//
//  Coordinator.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/23/23.
//

import UIKit

protocol Coordinator {
    var  childCoordinators  : [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
