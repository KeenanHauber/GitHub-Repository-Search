//
//  Buildable.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 14/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol Buildable {
    associatedtype Builder: Builds
    static func build(block: (Builder) -> Void) -> Builder.Built
}

extension Buildable {
    static func build() -> Builder.Built {
        return build(block: { _ in })
    }
}

protocol Builds {
    associatedtype Built
    func build() -> Built
}
