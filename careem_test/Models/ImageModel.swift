//
//  ImageModel.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation
//import ObjectMapper

enum ImageSize: Int {
    case small = 92
    case mid = 185
    case large = 500
    case extraLarge = 780
    
    func urlSize() -> String {
        return "/w" + String(self.rawValue)
    }
}

struct ImageModel {
    
    private var imagePath: String? {
        didSet(newPath) {
            if let newPath = newPath {
                imagePath = String(newPath.dropFirst(1))
            }
        }
    }
    
    init(imagePath : String?) {
        self.imagePath = imagePath
    }
    
    func imageUrl(size: ImageSize = .mid) -> URL? {
        if let imagePath = imagePath {
            return URL(string: Config.PostersServer.BaseUrl + size.urlSize() + imagePath)
        }
        return nil
    }
}
