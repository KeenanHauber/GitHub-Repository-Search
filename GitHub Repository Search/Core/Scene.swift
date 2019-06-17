//
//  Scene.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

protocol Scene {
    /// Constructs the scene, returning its view controller so it may be presented
    func build() -> UIViewController
}
