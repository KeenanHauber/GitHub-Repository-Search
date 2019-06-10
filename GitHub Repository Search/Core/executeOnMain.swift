//
//  executeOnMain.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

/// Executes code on the main thread.
///
/// - parameter target: the object to be weakly captured by the block
/// - parameter block: the block to be executed on the target
///
/// A weak reference is maintained to the target until the block is to be executed.
func executeOnMain<Target: AnyObject>(target: Target, block: @escaping (Target) -> Void) {
    if Thread.isMainThread {
        block(target)
    } else {
        DispatchQueue.main.async { [weak target] in
            guard let target = target else {
                return
            }
            block(target)
        }
    }
}
