//
//  MovieModel.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import ObjectMapper

struct MovieModel: Mappable {
    
    var movieId: Int?
    var title: String?
    var overview: String?
    private(set) var posterModel: ImageModel?
    private(set) var backdropModel: ImageModel?
    private var releaseDate: Date?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        movieId <- map["id"]
        title <- map["title"]
        overview <- map["overview"]
        releaseDate <- (map["release_date"], DateFormatterTransform(dateFormatter: DateFormatter.instance.movie))
//      posterModel <- map["poster_path"]
//      backdropModel <- map["backdrop_path"]
        posterModel = ImageModel(imagePath: map.JSON["poster_path"] as? String)
        backdropModel = ImageModel(imagePath: map.JSON["backdrop_path"] as? String)
    }
    
    func formattedDate() -> String? {
        if let date = self.releaseDate {
            let year = Calendar.current.component(.year, from: date)
            return String(year)
        }
        return nil
    }
}
