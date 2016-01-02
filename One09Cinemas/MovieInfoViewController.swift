//
//  MovieInfoViewController.swift
//  One09Cinemas
//
//  Created by nobukatsu on 2015/11/01.
//  Copyright © 2015年 nobukatsu. All rights reserved.
//

import UIKit
import SDWebImage

class MovieInfoViewController: UIViewController {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    var movieDetailUrl = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        // Do any additional setup after loading the view.
        let movie:Movie = Movie(detailUrl: movieDetailUrl)

        movieTitle.text = movie.title
        movieImage.sd_setImageWithURL(NSURL(string: movie.imageUrl))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
