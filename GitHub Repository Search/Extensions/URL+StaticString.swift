//
//  URL+StaticString.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

extension URL {
    /// Convenience initialiser for known URLs that will always be valid.
    ///
    /// To ensure that all URLs using this initialiser are valid, their initialisation should be tested.
    init(staticString: StaticString) {
        self.init(string: String(staticString))!
    }
}
