//
//  OrganisationSearchPresenter.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol OrganisationSearchPresenting {
    /// Instructs the `OrganisationSearchDisplay` on actions that should be taken based on the state
    func presentFetchState(_ fetchState: FetchState<[Organisation], Error>)
}

final class OrganisationSearchPresenter: OrganisationSearchPresenting {
    
    // MARK: - Dependencies
    
    // weak to prevent Display -> Interactor -> Presenter -> Display strong retain cycle
    weak var display: OrganisationSearchDisplay?
    
    // MARK: - Lifecycle
    
    init(display: OrganisationSearchDisplay) {
        self.display = display
    }
    
    // MARK: - OrganisationSearchPresenting
    
    func presentFetchState(_ fetchState: FetchState<[Organisation], Error>) {
        switch fetchState {
        case .fetching:
            display?.displayBusyState()
        case let .failure(error):
            display?.displayErrorMessage(error.localizedDescription)
        case let .success(organisations):
            display?.displayOrganisations(organisations.map { $0.name })
        }
    }
}
