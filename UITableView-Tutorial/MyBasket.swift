//
//  MyBasket.swift
//  UITableView-Tutorial
//
//  Created by MoAir on 2015-09-09.
//  Copyright (c) 2015 Mo. All rights reserved.
//

import UIKit

class MyBasket: UIViewController,UITableViewDelegate ,UITableViewDataSource,UISearchControllerDelegate, UISearchBarDelegate,UISearchResultsUpdating {
    
    @IBOutlet weak var cartTable: UITableView!
    let myBasketCellIdentifier = "myBasket"
    let searchTableCellIdentifier = "searchTable"
    var myBasket = [String]()
    let arr = ["1","2","3","4","51","11"]
    var filter = [String]()
    
    var resultSearchController = UISearchController()
    var tableViewControllerForSearch = UITableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: self.tableViewControllerForSearch)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
             controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.delegate = self
           controller.delegate = self
            self.navigationItem.titleView = controller.searchBar
            return controller
        })()
        self.definesPresentationContext = true
        self.tableViewControllerForSearch.tableView.dataSource = self
        self.tableViewControllerForSearch.tableView.delegate = self
        self.tableViewControllerForSearch.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.searchTableCellIdentifier)
//        self.myBasket.append("12")
//        self.myBasket.append("13")

        
    }
   
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
            //print("ad")
        filter.removeAll(keepCapacity: false)
        self.filterContentForSearchText(searchController.searchBar.text)
        
       self.tableViewControllerForSearch.tableView.reloadData()
    }
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.filter = self.arr.filter({( candy: String) -> Bool in
            //  let categoryMatch = (scope == "All") || (candy.category == scope)
            let stringMatch = candy.rangeOfString(searchText)
            //return categoryMatch && (stringMatch != nil)
            return (stringMatch != nil)

            
        })
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.resultSearchController.active) {
            let index = tableView.indexPathForSelectedRow()
            let rowSelect = tableView.cellForRowAtIndexPath(index!)
            let rowVlaue = rowSelect!.textLabel!.text!
            self.myBasket.append(rowVlaue)
            self.cartTable.reloadData()

            print(rowVlaue)
        }
       
        

    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        print(searchBar)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == self.tableViewControllerForSearch.tableView){
            return self.filter.count

        }else if(tableView == self.cartTable){
            return self.myBasket.count

        }else
        {
            return 0
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(tableView == self.tableViewControllerForSearch.tableView){
            let searchTableCell = tableView.dequeueReusableCellWithIdentifier(self.searchTableCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
            
                searchTableCell.textLabel?.text = filter[indexPath.row]
                return searchTableCell
        }else if(tableView == self.cartTable){
            let cartTableCell = tableView.dequeueReusableCellWithIdentifier(self.myBasketCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
                
                cartTableCell.textLabel?.text = myBasket[indexPath.row]
                return cartTableCell
        }
        else{
            return UITableViewCell()
        }

    }
}