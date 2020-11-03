//
//  MovieCell.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 31/10/20.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImg     :UIImageView!
    @IBOutlet weak var titleLbl     : UILabel!
    @IBOutlet weak var averageLbl   : UILabel!
    @IBOutlet weak var countVotesLbl: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell (movie : Movie){
        titleLbl.text = movie.title
        averageLbl.text = String(movie.voteAverage)
        countVotesLbl.text = String(movie.voteCount)
        
        guard let posterPath = movie.posterPath else { return }
        let imgPath = MovieAPI.build(image: posterPath, size: MovieAPI.ImageSize.w200)
        if let url = URL(string:imgPath){
            movieImg.sd_imageIndicator = SDWebImageActivityIndicator.medium
            movieImg.sd_setImage(with: url, placeholderImage: K.imgPlaceholder)
        }
    }
}
