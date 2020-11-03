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
    var movieSelected : Movie?
    var genreSelected : Genre?
    let alertManager = AlertManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getMovieList(page: page)
        
       

    }
    
    func getMovieList(page:Int){
        MovieListWorker().fetchMovieList(
            section: .popular, page: page,
            sucess: { [self] response in
                guard let movies = response?.results else { return }
                self.movie.append(contentsOf: movies)
                if self.movie.count < 20 {self.hasMoreMovies = false}
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            },
            failure: { error in
                print(error!)
                self.presentAlertOnMainThread(title: "Sorry!", body: "Please verify your connection.", buttonTitle: "OK")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = movie[indexPath.row]
        performSegue(withIdentifier: K.Segue.segueDetail, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        guard let destination = segue.destination as? DetailViewController else { return}
        destination.movie = movieSelected

    }
    
}
