//
//  DecimalExtension.swift
//  AcademyUI
//
//  Created by HANNA P C FERREIRA on 18/05/22.
//

import Foundation

extension Decimal {
    
    func currencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.currencySymbol = "R$"
        
        return formatter.string(from: self as NSDecimalNumber)!
    }
    
    func fuelCurrencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 3
        formatter.maximumFractionDigits = 3
        formatter.currencySymbol = "R$"
        
        return formatter.string(from: self as NSDecimalNumber)!
    }
    
}
