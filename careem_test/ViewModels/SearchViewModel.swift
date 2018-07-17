//
//  SearchViewModel.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import RealmSwift
import Realm

let kSuggestionsLimit: Int = 10

class SearchViewModel: SearchViewModelProtocol {
    
    typealias QueryType = SearchQueryModel
    
    /// current query model
    private(set) var queryModel = SearchQueryModel()
    /// recent queries models & strings
    private(set) var suggestions = List<SearchQueryModel>()
    private(set) var suggestionsStrings = [String]()
    
    init() {
        DispatchQueue.global().async {
            self.loadSuggestionsFromCache()
        }
    }
    
    private func loadSuggestionsFromCache() {
        self.suggestions = RealmManager.shared.get(SearchQueryModel.self, sortKey: #keyPath(SearchQueryModel.date), prefix: kSuggestionsLimit)
        self.suggestionsStrings = self.suggestions.map { $0.term }
    }
    
    func updateQuery(_ term: String) {
        queryModel = SearchQueryModel(term: term)
    }
    
    func storeQuery(query: SearchQueryModel) {
        DispatchQueue.global().async {
            RealmManager.shared.store(query.detached());
            self.loadSuggestionsFromCache()
        }
    }
}
