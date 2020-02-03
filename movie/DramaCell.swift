//
//  DramaCell.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 1/28/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher
class DramaCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        imageView.layer.cornerRadius = 10
    }
    func configureCell( movie:Movie){
        guard let url = URL(string:"https://image.tmdb.org/t/p/w500\(movie.posterPath)") ?? URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg") else { return  }
        
        imageView.kf.setImage(with: .network(url))
    }
    
    
}
