//
//  GenrePickerViewController.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 02/11/20.
//

import UIKit

class GenrePickerViewController: UIViewController {
    
    @IBOutlet weak var genrePickerView : UIPickerView!

    var genres1 = [Genre]()
    
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
                print(self.genres1)
                print(self.genres1.count)
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
    
   
    @IBAction func genreSelected(_ sender: UIButton) {
    }
    

}
extension GenrePickerViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(genres1.count)
        return genres1.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres1[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedGenre = genres1[row].name
    }
    
    
}
