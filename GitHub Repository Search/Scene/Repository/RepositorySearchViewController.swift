//
//  RepositorySearchViewController.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

protocol RepositorySearchResultsDisplay: AnyObject {
    func displayResults(_ results: [String])
}

final class RepositorySearchViewController: UITableViewController, RepositorySearchResultsDisplay {
    
    // MARK: - Constants
    
    static private let reuseIdentifier = "tableCellViewReuseIdentifier"
    
    // MARK: - Dependencies
    var interactor: RepositorySearchResultsInteracting!
    
    // MARK: - Properties
    
    /// A list of GitHub Repositories
    private var repositories: [String] = []
    
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: RepositorySearchViewController.reuseIdentifier)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.tableFooterView = UIView()
        
        interactor.loadResults()
    }
    
    // MARK: - RepositorySearchResultsDisplay
    
    func displayResults(_ results: [String]) {
        executeOnMain(target: self) { display in
            display.repositories = results
            display.tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositorySearchViewController.reuseIdentifier, for: indexPath)

        cell.textLabel?.text = repositories[indexPath.row]
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.selectResult(at: indexPath.row)
    }
}
