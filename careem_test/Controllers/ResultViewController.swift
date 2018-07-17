//
//  ResultViewController.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, ResultViewControllerProtocol {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noSearchResultsLabel: UILabel!
    
    private let viewModel /*: ResultViewModelProtocol*/ = ResultViewModel()
    weak var delegate: ResultViewControllerDelegate?
    var queryModel: SearchQueryModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func loadData(initial: Bool = false) {
        guard let queryModel = queryModel else { return }
        
        viewModel.searchForNextPage(queryModel).done { [weak self] updateUI in
            if updateUI {
                self?.updateUI()
                if (initial) {
                    self?.saveQuery()
                }
            }
        }.catch { [weak self] (error) in
            //todo show alert with error description
            self?.updateUI()
            if (initial) {
                self?.delegate?.didFailToLoadMovies(self!, error: error)
            }
        }
    }

    func updateUI() {
        if dataSource().count == 0 {
            noSearchResultsLabel.isHidden = false
            tableView.isHidden = true
        } else {
            noSearchResultsLabel.isHidden = true
            tableView.reloadData()
            tableView.isHidden = false
        }
    }
    
    func saveQuery() {
        if (self.dataSource().count > 0) {
            self.delegate?.didLoadMovies(self)
        }
    }
    
    func dataSource() -> [MovieModel] {
        return viewModel.searchMovies
    }
}

// MARK: - UITableViewDataSource
extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let loadingCell = viewModel.pagination.isLastPage() ? 0 : 1
        return dataSource().count == 0 ? 0 : dataSource().count + loadingCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataSource().count > 0 && dataSource().count == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell") as! LoadingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
            cell.data = viewModel.searchMovies[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource().count > 0 && dataSource().count == indexPath.row {
            if viewModel.isLoading == false {
                loadData()
            }
        }
    }
}

