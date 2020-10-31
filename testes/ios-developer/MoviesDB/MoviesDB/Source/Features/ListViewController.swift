//
//  ViewController.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // EXEMPLO DE COMO OBTER A LISTA DE FILMES POPULARES
        listaFilmes()
       
        
        
        // EXEMPLO DE COMO OBTER OS DETALHES DE UM FILME
        

        
        
        // EXEMPLO DE COMO OBTER A LISTA GÊNEROS
        

    }
    
    func listaFilmes(){
        MovieListWorker().fetchMovieList(
            section: .popular, page: 1,
            sucess: { response in
                guard let movies = response?.results else { return }
                print(movies)
            },
            failure: { error in
                print(error!)
            })
    }
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

