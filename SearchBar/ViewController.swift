//
//  ViewController.swift
//  SearchBar
//
//  Created by Edward P. Legaspi on 17/12/2015.
//  Copyright © 2015 Brood Camp. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    
    
    
    var candies = [Candy]()
    
    var filteredCandies = [Candy]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        candies = [
            Candy(category:"One", name:"LETTER A"),
            Candy(category:"TWO", name:"LETTER B"),
        ]
       
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredCandies.count
        }else{
            return candies.count
        }
 
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let candy: Candy
        
        if searchController.active && searchController.searchBar.text != "" {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category
        
        return cell
    }
    
    

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCandies = candies.filter { candy in
            return candy.name.lowercaseString.containsString(searchText.lowercaseString) || candy.category.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    
}

