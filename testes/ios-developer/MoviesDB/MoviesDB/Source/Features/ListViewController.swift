//
//  ViewController.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import UIKit
import SDWebImage


class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var movie : [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        listaFilmes()

    }
    // EXEMPLO DE COMO OBTER A LISTA DE FILMES POPULARES
    func listaFilmes(){
        MovieListWorker().fetchMovieList(
            section: .popular, page: 1,
            sucess: { response in
                guard let movies = response?.results else { return }
                self.movie = movies
                print("++++++********++++++")
                print(self.movie)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            },
            failure: { error in
                print(error!)
            })
    }
    // EXEMPLO DE COMO OBTER OS DETALHES DE UM FILME
    func detalheFilmes(){
        MovieDetailsWorker().fetchMovieDetails(
            of: 497582, // COLOQUE O ID DO FILME AQUI
            sucess: { details in
                guard let details = details else { return }
                print(details)
            },
            failure: { error in
                print(error!)
            })
    }
    // EXEMPLO DE COMO OBTER A LISTA GÊNEROS
    func listaGeneros(){
        GenreListWorker().fetchGenreList(
            sucess: { response in
                guard let genres = response?.genres else { return }
                print(genres)
            },
            failure: { error in
                print(error!)
            })
    }
}

extension ListViewController : UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movie.count)
        return movie.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)as! MovieCell

        cell.titleLbl.text = movie[indexPath.row].title
        let avg = movie[indexPath.row].voteAverage
        let vote = movie[indexPath.row].voteCount
        cell.averageLbl.text = String(avg)
        cell.countVotesLbl.text = String(vote)
        let posterPath = (movie[indexPath.row].posterPath)!
        let imgPath = MovieAPI.build(image: posterPath, size: MovieAPI.ImageSize.w200)
        cell.movieImg.sd_setImage(with: <#T##URL?#>, placeholderImage: <#T##UIImage?#>, options: <#T##SDWebImageOptions#>)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
