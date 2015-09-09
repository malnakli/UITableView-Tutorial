//
//  CandyTableViewController.swift
//  UITableView-Tutorial
//
//  Created by MoAir on 2015-09-09.
//  Copyright (c) 2015 Mo. All rights reserved.
//

import UIKit

// UISearchBarDelegate defines the behavior and response of a search
// UISearchDisplayDelegate defines the look and feel of the search bar.
class CandyTableViewController: UITableViewController , UISearchResultsUpdating{

    var candies = [Candy]()
    var filteredCandies = [Candy]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.candies = [Candy(category:"Chocolate", name:"chocolate Bar"),
            Candy(category:"Chocolate", name:"chocolate Chip"),
            Candy(category:"Chocolate", name:"dark chocolate"),
            Candy(category:"Hard", name:"lollipop"),
            Candy(category:"Hard", name:"candy cane"),
            Candy(category:"Hard", name:"jaw breaker"),
            Candy(category:"Other", name:"caramel"),
            Candy(category:"Other", name:"sour chew"),
            Candy(category:"Other", name:"gummi bear")]
        
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        if (self.resultSearchController.active) {
            return self.filteredCandies.count
        }
        else {
            return self.candies.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // 3
        if (self.resultSearchController.active) {
            cell.textLabel?.text = filteredCandies[indexPath.row].name
            
            return cell
        }
        else {
            cell.textLabel?.text = candies[indexPath.row].name
            
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredCandies.removeAll(keepCapacity: false)
            print(searchController.searchBar.text)
        self.filterContentForSearchText(searchController.searchBar.text)
        self.tableView.reloadData()
    }
    
    //  filter()  {(parameters) -> (return type) in expression statements}
    // rangeOfString() checks if a string contains another string. If it does and the category also matches, you return true and the current candy is included in the filtered array; if it doesn’t you return false and the current candy is not included.
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.filteredCandies = self.candies.filter({( candy: Candy) -> Bool in
            //  let categoryMatch = (scope == "All") || (candy.category == scope)
            let stringMatch = candy.name.rangeOfString(searchText)
            //return categoryMatch && (stringMatch != nil)
            return (stringMatch != nil)
            
            
        })
    }
    
}
