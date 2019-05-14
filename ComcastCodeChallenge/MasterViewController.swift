//
//  MasterViewController.swift
//  ComcastCodeChallenge
//
//  Created by Eladio Alvarez Valle on 5/14/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, ModelToView {

    var detailViewController: DetailViewController? = nil
    
    let searchController = UISearchController(searchResultsController: nil)
    lazy var model : MasterViewModel = {
        return MasterViewModel(delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        //Add search to table view
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        //Fetch data
        self.model.fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = model.getCharacter(index: indexPath.row)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.object = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.getNumberOfElements()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = self.model.getCharacter(index: indexPath.row)
        cell.textLabel!.text = object.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    //MARK : ModelToView methods implementation
    func updateData() {
        
        self.tableView.reloadData()
    }


}

// Extension for Search Result
extension MasterViewController: UISearchResultsUpdating {
    
    /// Update search results
    func updateSearchResults(for searchController: UISearchController) {
        
        if let keyword = searchController.searchBar.text {
            
            self.model.filterData(keyword: keyword)
            
        }
        
    }
}
