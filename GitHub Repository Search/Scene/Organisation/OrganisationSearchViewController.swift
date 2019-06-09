//
//  OrganisationTableViewController.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

protocol OrganisationSearchDisplay: AnyObject {
    func displayOrganisations(_ organisations: [String])
}

class OrganisationSearchViewController: UITableViewController, OrganisationSearchDisplay, UISearchBarDelegate {
    
    // MARK: - Constants
    
    static private let reuseIdentifier = "tableCellViewReuseIdentifier"
    
    // MARK: - Dependencies
    
    var interactor: OrganisationSearchInteracting!
    
    // MARK: - Properties
    
    private var organisations: [String] = []
    
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // search bar
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search GitHub Organisations"
        navigationItem.titleView = searchBar
        
        searchBar.delegate = self
        
        // table view
        
        // set an empty view as the footer view to prevent dividers proliferating down the screen
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: OrganisationSearchViewController.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: - OrganisationSearchResultsDisplay
    
    func displayOrganisations(_ organisations: [String]) {
        executeOnMain(target: self) { display in
            display.organisations = organisations
            display.tableView.reloadData()
        }
    }
    
    func displayFetchSucceeded() {
        // stop spinner
    }
    
    func displayFetchFailed() {
        // stop spinner
    }
    
    func displayFetchInProgress() {
        // Start spinner
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            interactor.searchForOrganisations(named: text)
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organisations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrganisationSearchViewController.reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = organisations[indexPath.row]
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.selectedOrganisationAt(row: indexPath.row)
    }
}
