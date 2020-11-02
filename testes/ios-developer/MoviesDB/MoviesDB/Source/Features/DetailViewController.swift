//
//  DetailViewController.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 31/10/20.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieTitleLbl : UILabel!
    @IBOutlet weak var overviewLbl : UILabel!
    @IBOutlet weak var castLbl : UILabel!
    @IBOutlet weak var crewLbl : UILabel!
    @IBOutlet weak var runtimeLbl: UILabel!
    @IBOutlet weak var releaseDateLbl : UILabel!
    @IBOutlet weak var renevueLbl: UILabel!
    @IBOutlet weak var budgetLbl:UILabel!
    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var imgPoster : UIImageView!
    @IBOutlet weak var genreLbl : UILabel!
    
    var movie : Movie?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        title = movie?.title
        getMovieDetails()
        configureImg()
        configureImgBackdrop()
        configureView()
        
    }

//MARK: - Chamada API
    func getMovieDetails(){
        guard  let id = movie?.id else { return}
            MovieDetailsWorker().fetchMovieDetails(
                of: id,
                sucess: { [self] details in
                    guard let details = details else { return }
                    
                    var budget = (details.budget)
                    var revenue = (details.revenue)
                    
                    
                    var runtime = String(details.runtime)
                    var completeGenre = ""
                    for genre in details.genres{
                        completeGenre += genre.name + " \n "
                    }
                    var completeCast = ""
                    for cast in details.credits.cast{
                        completeCast += cast.name + " - " +  cast.character + "\n"
                    }
                    var completeCrew = ""
                    for crew in details.credits.crew{
                        completeCrew += crew.name + " - " + crew.job + "\n"
                    }
                    DispatchQueue.main.async {
                        self.castLbl.text = completeCast
                        self.crewLbl.text = completeCrew
                        self.budgetLbl.text = String(budget.currencyFormat)
                        self.renevueLbl.text = String (revenue.currencyFormat)
                        self.runtimeLbl.text = "\(runtime) min."
                        self.genreLbl.text = completeGenre
                    }
                    

                },
                failure: { error in
                    print(error!)
                })
        
    }
   
    //MARK : - Atualização da View
    func configureView(){
        DispatchQueue.main.async {
            self.movieTitleLbl.text = self.movie?.title
            self.overviewLbl.text = self.movie?.overview
            self.releaseDateLbl.text = self.movie?.relaseDateFormatted
        }
    }

    
    func configureImg(){
        guard let posterPath = movie?.posterPath else { return }
        let imgPosterPath = MovieAPI.build(image: posterPath, size: MovieAPI.ImageSize.w200)
        if let url = URL(string:imgPosterPath){
            imgPoster.sd_imageIndicator = SDWebImageActivityIndicator.medium
            imgPoster.sd_setImage(with: url, placeholderImage: K.imgPlaceholder)
    }
}
    func configureImgBackdrop (){
        guard let backdropPath = movie?.backdropPath else { return}
        let imgBackdropPath = MovieAPI.build(image: backdropPath, size: MovieAPI.ImageSize.w500)
        print(imgBackdropPath)
        if let backdropURL = URL(string: imgBackdropPath){
            imgBackdrop.sd_imageIndicator = SDWebImageActivityIndicator.medium
            imgBackdrop.sd_setImage(with: backdropURL, placeholderImage: K.imgPlaceholder)
        }
    }
}


