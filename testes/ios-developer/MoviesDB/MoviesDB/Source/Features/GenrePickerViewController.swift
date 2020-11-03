//
//  GenrePickerViewController.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 02/11/20.
//

import UIKit

class GenrePickerViewController: UIViewController {
    
    @IBOutlet weak var genrePickerView : UIPickerView!
    @IBOutlet weak var button:UIButton!

    
    var genres1 = [Genre]()
    var selectedGenre = ""
    var genreInt = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setUpPickerView()
         getGenres()
      
        
    }
    
    // EXEMPLO DE COMO OBTER A LISTA GÊNEROS
    func getGenres(){
        GenreListWorker().fetchGenreList(
            sucess: { response in
                guard let genres = response?.genres else { return }
                self.genres1 = genres
                DispatchQueue.main.async {
                    self.genrePickerView.reloadComponent(0)
                }
            },
            failure: { error in
                print(error!)
            })
       
    }
    
    func setUpPickerView(){
        genrePickerView.delegate   = self
        genrePickerView.dataSource = self
        genrePickerView.setValue(UIColor.systemGreen, forKey: "textColor")
        genrePickerView.setValue(UIColor.black, forKey: "backgroundColor")
    }

}
extension GenrePickerViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres1.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres1[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedGenre = genres1[row].name
        genreInt = genres1[row].id
        
        performSegue(withIdentifier: K.Segue.segueListFiltered, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ListFilteredViewController else { return}
        destination.genreSelected = selectedGenre
        destination.genreID = genreInt
    }
    
    
}

