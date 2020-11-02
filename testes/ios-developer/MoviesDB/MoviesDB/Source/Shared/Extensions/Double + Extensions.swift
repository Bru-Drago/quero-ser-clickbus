//
//  Double + Extensions.swift
//  MoviesDB
//
//  Created by Bruna Fernanda Drago on 02/11/20.
//

import Foundation

extension Double {
    
     var currencyFormat : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        formatter.currencyDecimalSeparator = "."
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: self))!
    }

}
