//
//  OrganisationSearchPresenter.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

enum FetchState {
    case fetching
    case failed
    case success
}

protocol OrganisationSearchPresenting {
    func presentOrganisations(_ organisations: [Organisation])
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
    
    #warning("incomplete implementation")
    func presentFetchState(_ fetchState: FetchState) {
//        switch fetchState {
//            
//        }
    }
    
    func presentOrganisations(_ organisations: [Organisation]) {
        display?.displayOrganisations(organisations.map { $0.name })
    }
}
