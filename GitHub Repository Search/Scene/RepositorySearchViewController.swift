//
//  RepositorySearchViewController.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

final class RepositorySearchViewController: UITableViewController {
    
    // MARK: - Constants
    
    static private let reuseIdentifier = "tableCellViewReuseIdentifier"
    
    // MARK: - Properties
    
    /// A list of GitHub Repositories
    var searchResults: [Repository] = []
    
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: RepositorySearchViewController.reuseIdentifier)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.tableFooterView = UIView()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositorySearchViewController.reuseIdentifier, for: indexPath)

        cell.textLabel?.text = searchResults[indexPath.row].name
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(searchResults[indexPath.row].htmlURL)
    }
}
