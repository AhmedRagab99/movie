//
//  SearchVC.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 2/3/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import MBProgressHUD

class SearchVC: UIViewController,UISearchResultsUpdating {
    
    
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var MoviesData:[Movie] = []
    var FilterdData:[Movie]=[]
    var search = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        getMovies()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        search.searchResultsUpdater = self
    }
    
    //MARK:- filterMoviesData
    func filterMoviesData(for searchText: String) {
        FilterdData = MoviesData.filter { data in
            return data.title.contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterMoviesData(for: searchController.searchBar.text ?? "")
        
    }
    
    
    
    
    func showIndicator(withTitle title: String, and Description:String) {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = title
        Indicator.isUserInteractionEnabled = false
        Indicator.detailsLabel.text = Description
        Indicator.show(animated: true)
    }
    
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    
    //MARK:- searchbar UI
    func setupNavBar(){
        search.searchBar.placeholder = "search Movie"
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "search"
    }
    
    
    //MARK:- fetch api
    func getMovies(){
        showIndicator(withTitle: "loading", and: "")
        Alamofire.request(baseUrl).responseJSON{ response in
            
            switch response.result{
            case .success( _):
                guard let resultss = try? coder.decode(Results.self, from: response.data!) else { fatalError("unable to parse data to json")}
                
                
                for i in resultss.results.enumerated(){
                    // print(resultss.results[i.offset].posterPath)
                    self.MoviesData.append(resultss.results[i.offset])
                }
                self.hideIndicator()
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}


//MARK:-  table view extentions

extension SearchVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search.isActive && search.searchBar.text != ""{
            return FilterdData.count
        }
        return MoviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data:Movie
        if    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTVCell{
            
            if search.isActive && search.searchBar.text != "" {
                data = self.FilterdData[indexPath.row]
            }
            else {
                data = self.MoviesData[indexPath.row]
            }
            cell.configureTableCell(movie: data)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = (self.view.bounds.height/3 ) - 15
        return CGFloat(height)
    }
    
}
