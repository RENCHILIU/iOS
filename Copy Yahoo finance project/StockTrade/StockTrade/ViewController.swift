//
//  ViewController.swift
//  SwiftStockExample
//
//  Created by Mike Ackley on 5/3/15.
//  Copyright (c) 2015 Michael Ackley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
  var searchResults: [BestMatch] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    tableView.tableFooterView = UIView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "StockCell", bundle: Bundle.main), forCellReuseIdentifier: "stockCell")
    tableView.rowHeight = 60
    searchBar.delegate = self
    
  }
  
  
  // *** Here's the important bit *** //
  func searchYahooFinanceWithString(searchText: String) {
    
    SwiftStockKit.fetchStocksFromSearchTerm(term: searchText) { (stockInfoArray) -> () in
      
      self.searchResults = stockInfoArray
      self.tableView.reloadData()
      
    }
    
  }
  
  
  
  // Search code
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    let length = searchText.count
    
    if length > 0 {
      searchYahooFinanceWithString(searchText: searchText)
    } else {
      searchResults.removeAll()
      tableView.reloadData()
    }
    
  }
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.showsCancelButton = true
    tableView.reloadData()
    return true
  }
  
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.showsCancelButton = false
    tableView.reloadData()
    return true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.text = ""
  }
  
  
  //SearchBar stuff
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func keyboardWillShow(sender: NSNotification) {
    if let userInfo = sender.userInfo {
      let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
      tableViewBottomConstraint.constant = keyboardHeight
      UIView.animate(withDuration: 0.25, animations: { () -> Void in
        self.view.layoutIfNeeded()
      })
      
    }
  }
  
  @objc func keyboardWillHide(sender: NSNotification) {
    if sender.userInfo != nil {
      
      tableViewBottomConstraint.constant = 0.0
      UIView.animate(withDuration: 0.25, animations: { () -> Void in
        self.view.layoutIfNeeded()
      })
    }
  }
  
  
  //TableView stuff
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let controller: DetailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
    controller.stockSymbol = searchResults[indexPath.row].symbol
    navigationController?.pushViewController(controller, animated: true)
    
    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell: StockCell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
    cell.symbolLbl.text = searchResults[indexPath.row].symbol
    cell.companyLbl.text = searchResults[indexPath.row].name
    let exchange = searchResults[indexPath.row].exchange
    let assetType = searchResults[indexPath.row].assetType
    cell.infoLbl.text = exchange + "  |  " + assetType
    
    return cell
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

