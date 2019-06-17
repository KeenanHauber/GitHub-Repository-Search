//
//  NavigationControlling.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

protocol NavigationControlling {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

extension UINavigationController: NavigationControlling {}
