//
//  MovieCell.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {
    
    @IBOutlet private weak var poster: UIImageView!
    @IBOutlet private weak var banner: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        poster.af_cancelImageRequest()
        banner.af_cancelImageRequest()
    }
    
    var data: MovieModel? {
        didSet {
            guard let _ = data else { return }
            self.configureTitles()
            self.configurePosters()
        }
    }
    
    func configureTitles() {
        guard let data = self.data else { return }
        var fullTitle = ""
        if let title = data.title {
            fullTitle += title
            if let date = data.formattedDate() {
                fullTitle += " (\(date))"
            }
            titleLabel.text = fullTitle
        }
        if let description = data.overview {
            descriptionLabel.text = description
        }
    }
    
    func configurePosters() {
        guard let data = self.data else { return }
        
        let placeholderImage = UIImage(named: "Movie_icon")
        if let imageUrl = data.posterModel?.imageUrl() {
            poster.af_setImage(withURL: imageUrl, placeholderImage: placeholderImage, imageTransition: .crossDissolve(0.2))
        } else {
            poster.image = placeholderImage
        }
        if let imageUrl = data.backdropModel?.imageUrl() {
            banner.af_setImage(withURL: imageUrl, placeholderImage: placeholderImage, imageTransition: .crossDissolve(0.2))
        } else {
            banner.image = placeholderImage
        }
    }
    
}
