//
//  CountryCodeController.swift
//  User
//
//  Created by CSS on 20/02/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

class CountryCodeController: UIViewController {

    private let tableCellId = "countryCell"
    
    private var dataSource = [Country]()
    
    private var filterDataSource = [Country]()
    
    var countryCode : ((Country)->Void)?
    
    @IBOutlet private var tableViewCountry : UITableView!
    
    
    @IBOutlet private var searchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
    }
    
    
    //MARK:- Initial Loads
    
    private func initialLoads(){
        
        self.dataSource = Common.getCountries()
        self.filterDataSource = dataSource
        self.tableViewCountry.reloadData()
        self.searchBar.delegate = self
//        self.view.dismissKeyBoardonTap()
        self.searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

//MARK:- UITableViewDataSource, UITableViewDelegate

extension CountryCodeController : UITableViewDataSource, UITableViewDelegate {
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as? CountryTableViewCell {
            
            if filterDataSource.count>indexPath.row {
              
                 tableCell.set(values: filterDataSource[indexPath.row])
                 
            }
            return tableCell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filterDataSource.count == 0 {
            return dataSource.count
            
        }
        return filterDataSource.count
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dataSource.count>indexPath.row {
            
            self.countryCode?(filterDataSource[indexPath.row])
            self.popOrDismiss(animation: true)
        }
        
    }
    
    
}


//MARK:- UISearchBarDelegate

extension CountryCodeController : UISearchBarDelegate {
    
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        filterDataSource = dataSource.filter({ ($0.name+$0.code+$0.dial_code).lowercased().contains(searchText.lowercased())})
        print(filterDataSource)
        self.tableViewCountry.reloadData()
        
    }
    
}


