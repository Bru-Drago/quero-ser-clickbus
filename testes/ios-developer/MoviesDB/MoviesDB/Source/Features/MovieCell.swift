//
//  MovieCell.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 31/10/20.
//

import UIKit

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

}
