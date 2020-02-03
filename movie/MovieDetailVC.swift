//
//  MovieDetailVC.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 1/28/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit

import Kingfisher
class MovieDetailVC: UIViewController {
    
    var selectedMovie:Movie!
    @IBOutlet weak var overView: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rate:UILabel!
    @IBOutlet weak var releasseDate:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string:"https://image.tmdb.org/t/p/w500\(selectedMovie.posterPath)") ?? URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg") else { return  }
        print(selectedMovie.overview)
        self.imageView.layer.cornerRadius=30
        self.imageView.kf.setImage(with: .network(url))
        self.overView.text = selectedMovie.overview
        self.movieTitle.text = selectedMovie.title
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
}
