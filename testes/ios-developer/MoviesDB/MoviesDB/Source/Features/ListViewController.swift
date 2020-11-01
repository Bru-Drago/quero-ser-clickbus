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
    var page = 1
    var hasMoreMovies = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getMovieList(page: page)

    }
    // EXEMPLO DE COMO OBTER A LISTA DE FILMES POPULARES
    func getMovieList(page:Int){
        MovieListWorker().fetchMovieList(
            section: .popular, page: page,
            sucess: { response in
                guard let movies = response?.results else { return }
                //self.movie = movies
                self.movie.append(contentsOf: movies)
                if self.movie.count < 20 {self.hasMoreMovies = false}
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
        return movie.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)as! MovieCell
        cell.configureCell(movie: movie[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height{
            guard hasMoreMovies else { return}
            page += 1
            getMovieList(page: page)
        }
    }
    
}
