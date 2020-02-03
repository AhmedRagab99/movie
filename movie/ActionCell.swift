//
//  ActionCell.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 1/28/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher

class ActionCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    
    
    override func awakeFromNib() {
        posterImage.layer.cornerRadius = 20
    }
    func configureCell( movie:Movie){
        guard let url = URL(string:"https://image.tmdb.org/t/p/w500\(movie.posterPath)") ?? URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg") else { return  }
        
        posterImage.kf.setImage(with: .network(url))
    }
}
