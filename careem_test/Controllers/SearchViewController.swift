//
//  SearchViewController.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import PYSearch

class SearchViewController: PYSearchViewController {
    
    private let viewModel/*: SearchViewModelProtocol*/ = SearchViewModel()//SearchViewModel<SearchQueryModel>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSearchSettings()
    }
    
    func configureSearchSettings() {
        self.showHotSearch = false
        self.showSearchHistory = false
        self.searchResultShowMode = PYSearchResultShowMode.embed;
        self.searchViewControllerShowMode = PYSearchViewControllerShowMode.modeModal;
        self.searchSuggestionHidden = false
        self.searchHistoriesCachePath = ""
        self.searchHistoriesCount = 0
        
        self.cancelBarButtonItem = nil
        self.cancelButton = nil
        
        self.searchResultController = configureResultController()
        self.delegate = self
    }
    
    func configureResultController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        //can not specify generic UIViewController<ResultViewControllerProtocol> due to Storyboard initialization
        let vc = storyboard.instantiateViewController(withIdentifier: "ResultViewControllerId") as! ResultViewController
        vc.delegate = self
        return vc
    }
}

extension SearchViewController: PYSearchViewControllerDelegate {
    
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange searchBar: UISearchBar!, searchText: String!) {
        searchViewController.searchSuggestions = self.viewModel.suggestionsStrings
    }
    
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWith searchBar: UISearchBar!, searchText: String!) {
        
        viewModel.updateQuery(searchText)
        
        if let vc = searchViewController.searchResultController as? ResultViewControllerProtocol {
            vc.queryModel = viewModel.queryModel
            vc.loadData(initial: true)
        }
    }
}

extension SearchViewController: ResultViewControllerDelegate {
    
    func didLoadMovies(_ controller: ResultViewControllerProtocol) {
        if let queryModel = controller.queryModel {
            viewModel.storeQuery(query: queryModel)
        }
    }
    
    func didFailToLoadMovies(_ controller: ResultViewControllerProtocol, error: Error) {
        // handle errors if needed
    }
}
