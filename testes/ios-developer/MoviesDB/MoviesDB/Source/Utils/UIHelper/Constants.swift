//
//  Constants.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 01/11/20.
//

import UIKit

struct K {
    static let cellIdentifier = "MovieCell"
    static let imgPlaceholder = UIImage(named:"tmdb_img")
    
    struct Segue {
        static let segueDetail = "goToDetailVC"
        static let segueFilterPicker = "goToFilterGenreVC"
        static let segueListFiltered = "goToListFilteredVC"
        static let segueFilterToDetail = "filterToDetailVC"
        
    }
}
