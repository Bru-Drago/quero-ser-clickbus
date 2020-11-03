//
//  ListFilteredViewController.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 02/11/20.
//

import UIKit

class ListFilteredViewController: UIViewController {
    
    @IBOutlet weak var filteredTableView: UITableView!
    
    
    var genreSelected = ""
    var page = 1
    var hasMoreMovies = true
    var movieSelected : Movie?
    var filteredMovies = [Movie]()
    var genreID = 1
    let alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = genreSelected
        
        filteredTableView.delegate   = self
        filteredTableView.dataSource = self
        
        getListByGenre(page: page, genreID: genreID)
        
    }
    //MARK: - Efetuando chamada na API
    func getListByGenre(page:Int ,genreID: Int){
        MovieListWorker().fetchMovieListFiltered(genreID: genreID, page: page, sucess: { [self] response in
            guard let movies = response?.results else { return}
            self.filteredMovies.append(contentsOf: movies)
            if self.filteredMovies.count < 20 {self.hasMoreMovies = false}
            
            DispatchQueue.main.async {
                self.filteredTableView.reloadData()
            }
            
        }, failure: { error in
            print(error!)
            self.presentAlertOnMainThread(title: "Sorry", body: "Something bad happend! Try again!", buttonTitle: "OK")
        })
    }
    
}
extension ListFilteredViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)as! MovieCell
        
        cell.configureCell(movie: filteredMovies[indexPath.row])
        
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
            getListByGenre(page: page, genreID: genreID)
            
        }
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            movieSelected = filteredMovies[indexPath.row]
            performSegue(withIdentifier: K.Segue.segueFilterToDetail, sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            guard let destination = segue.destination as? DetailViewController else { return}
            destination.movie = movieSelected

        }
        
    }

