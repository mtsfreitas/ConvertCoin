//
//  CoinConverterViewModel.swift
//  ConvertCoin
//
//  Created by Matheus Freitas Martins on 14/08/23.
//

import Foundation

class CoinConverterViewModel {
    public func getCoins(params: String, onCompletion: @escaping (ExchangeCoins?, String?) -> Void) {
        WebService().getCoins(pathParam: params) { (data, error) in
            if let coins = data {
                onCompletion(coins, nil)
            } else {
                onCompletion(nil, error)
            }
        }
    }
    
    public func calculatedCoins(valueInfo: String, valueCoin: String) -> NSNumber {
        let value: Float = Float(valueInfo)!
        let coin: Float = Float(valueCoin)!
        let calc: Float = coin * value
        
        return NSNumber(value: calc)
    }
    
    public func getListCoins() -> [String] {
        return EnumCoins.allCases.map {$0.rawValue}
    }
    
}
