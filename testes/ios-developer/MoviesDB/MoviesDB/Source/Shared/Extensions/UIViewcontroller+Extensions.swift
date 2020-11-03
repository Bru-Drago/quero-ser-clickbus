//
//  UIViewcontroller+Extensions.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 03/11/20.
import UIKit

extension UIViewController {
    func presentAlertOnMainThread (title: String ,body: String ,buttonTitle:String){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Alert", bundle: .main)
            let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
            
            alertVC.alertTitle = title
            alertVC.alertBody = body
            alertVC.actionButtonTitle = buttonTitle
            
            self.present(alertVC,animated: true)
        }
    }
}
