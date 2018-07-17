//
//  ResultViewModel.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import PromiseKit

class ResultViewModel: ResultViewModelProtocol {
    
    typealias ModelType = MovieModel
    typealias QueryType = SearchQueryModel
    
    private(set) var pagination = PaginationModel.initial
    private(set) var searchMovies = [MovieModel]()
    private(set) var isLoading = false
    internal var queryModel: SearchQueryModel?
    
    //todo add a custom network promise with dataTask inside to cancel it properly
    //private var dataTask: URLSessionDataTask?
    
    func searchForNextPage(_ queryModel: SearchQueryModel) -> Promise<Bool> {
        if (self.queryModel?.term != queryModel.term) {
            cancelRequest()
        }
        if (self.isLoading == true || self.pagination.isLastPage()) {
            return Promise.value(false)
        }
        
        self.queryModel = queryModel
        self.isLoading = true
        
        let page = String(pagination.page)
        let target = Movie.search(queryModel.term, page)
        
        return Promise { seal in

            Rest.shared.mappableRequest(target).map(on: DispatchQueue.global(), { (searchResult: SearchResponseModel) -> () in
                
                    self.pagination = searchResult.pagination
                    self.pagination.incrementPage()
                    self.searchMovies.append(contentsOf: searchResult.movies)
                
                    seal.fulfill(true)
                    self.isLoading = false
                }).catch ({ (error) in
                    seal.reject(error)
                    self.isLoading = false
                })
            }
        }
    
    private func cancelRequest() {
        //cancel promise task
        self.pagination = PaginationModel.initial
        self.isLoading = false
        self.searchMovies.removeAll(keepingCapacity: true)
    }
}

