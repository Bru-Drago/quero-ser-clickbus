//
//  AlertManager.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 03/11/20.
//

import UIKit

class AlertManager {
    
    func alert(title: String ,body: String ,buttonTitle:String) -> AlertViewController {
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        
        alertVC.alertTitle = title
        alertVC.alertBody = body
        alertVC.actionButtonTitle = buttonTitle
        
        return alertVC
    }

}
