//
//  OrganisationSearchPresenter.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol OrganisationSearchPresenting {
    /// Formats the organisation data for presentation and instructs the `OrganisationSearchDisplay` to display it appropriately
    func presentOrganisations(_ organisations: [Organisation])
    /// Instructs the `OrganisationSearchDisplay` on actions that should be taken based on the state
    func presentFetchState(_ fetchState: FetchState)
}

final class OrganisationSearchPresenter: OrganisationSearchPresenting {
    
    // MARK: - Dependencies
    
    // weak to prevent Display -> Interactor -> Presenter -> Display strong retain cycle
    private weak var display: OrganisationSearchDisplay?
    
    // MARK: - Lifecycle
    
    init(display: OrganisationSearchDisplay) {
        self.display = display
    }
    
    // MARK: - OrganisationSearchPresenting
    
    func presentFetchState(_ fetchState: FetchState) {
        #warning("incomplete implementation")
//        switch fetchState {
//            
//        }
    }
    
    func presentOrganisations(_ organisations: [Organisation]) {
        display?.displayOrganisations(organisations.map { $0.name })
    }
}
