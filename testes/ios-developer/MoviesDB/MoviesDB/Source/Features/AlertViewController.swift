//
//  AlertViewController.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 03/11/20.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var alertContainerView : UIView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var bodyLbl : UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    
    var alertTitle = String()
    var alertBody = String()
    var actionButtonTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        setUpAlert()
    }
    
    func setUpAlert(){
        titleLbl.text = alertTitle
        bodyLbl.text = alertBody
        actionBtn.setTitle(actionButtonTitle, for: .normal)
        actionBtn.layer.cornerRadius = 10
        alertContainerView.layer.cornerRadius = 16
        alertContainerView.backgroundColor = .systemBackground
    }
    
    @IBAction func actionTapped(_ sender: UIButton){
        dismiss(animated: true)
    }

}
