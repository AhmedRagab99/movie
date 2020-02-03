//
//  MovieTVCellTableViewCell.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 2/3/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit

class MovieTVCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var overView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.poster.layer.cornerRadius = 40
        // Initialization code
    }
    
    func configureTableCell(movie:Movie){
        
        guard let url = URL(string:"https://image.tmdb.org/t/p/w500\(movie.posterPath)") ?? URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg") else { return  }
        
        poster.kf.setImage(with: .network(url))
        
        self.movieTitle.text = (movie.title)
        self.overView.text = movie.overview
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
