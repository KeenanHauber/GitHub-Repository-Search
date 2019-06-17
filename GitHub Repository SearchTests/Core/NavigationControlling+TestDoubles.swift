//
//  NavigationControllingSpy.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit
@testable import GitHub_Repository_Search

final class NavigationControllingSpy: NavigationControlling {
    private(set) var parametersFor_pushViewController: [(viewController: UIViewController, animated: Bool)] = []
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        parametersFor_pushViewController.append((viewController, animated))
    }
}
