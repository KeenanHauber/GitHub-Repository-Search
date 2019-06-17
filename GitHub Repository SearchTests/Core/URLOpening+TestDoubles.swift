//
//  URLOpening+TestDoubles.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit
@testable import GitHub_Repository_Search

final class URLOpeningDummy: URLOpening {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?) {}
}

final class URLOpeningSpy: URLOpening {
    private(set) var parametersFor_openURLOptionsCompletionHandler:
        [(url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?)]
        = []
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?) {
        parametersFor_openURLOptionsCompletionHandler.append((url, options, completionHandler))
    }
}
