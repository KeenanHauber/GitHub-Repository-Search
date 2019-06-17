//
//  URLOpening.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

protocol URLOpening {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?)
}

extension URLOpening {
    func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}

extension UIApplication: URLOpening {}
