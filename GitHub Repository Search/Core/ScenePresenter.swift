//
//  Routing.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol ScenePresenting {
    func pushViewController(for scene: Scene, to navigationController: NavigationControlling)
}
final class ScenePresenter: ScenePresenting {
    func pushViewController(for scene: Scene, to navigationController: NavigationControlling) {
        navigationController.pushViewController(scene.build(), animated: true)
    }
}
