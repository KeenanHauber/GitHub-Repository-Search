//
//  DummyScene.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit
@testable import GitHub_Repository_Search

final class DummyScene: Scene {
    private let testID: Int
    
    init(testID: Int) {
        self.testID = testID
    }
    func build() -> UIViewController {
        let viewController = DummySceneViewController()
        viewController.testID = testID
        return viewController
    }
}

final class DummySceneViewController: UIViewController {
    var testID: Int?
}
