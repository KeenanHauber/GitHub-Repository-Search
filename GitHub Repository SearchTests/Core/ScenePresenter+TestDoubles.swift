//
//  ScenePresenter+TestDoubles.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation
@testable import GitHub_Repository_Search

final class ScenePresentingDummy: ScenePresenting {
    func pushViewController(for scene: Scene, to navigationController: NavigationControlling) {}
}

final class ScenePresentingSpy: ScenePresenting {
    private(set) var parametersFor_pushViewController: [(scene: Scene, navigationController: NavigationControlling)] = []
    
    func pushViewController(for scene: Scene, to navigationController: NavigationControlling) {
        parametersFor_pushViewController.append((scene, navigationController))
    }
}
