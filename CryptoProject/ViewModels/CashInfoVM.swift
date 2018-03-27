//
//  CashInfoVM.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 2/26/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import Foundation

enum Coin: String, Codable {
    case BTC = "BTC"
    case ETH = "ETH"
    case OTN = "OTN"
    case NEO = "NEO"
    case XRP = "XRP"
    case ETC = "ETC"
    case BCH = "BCH"
    case LTC = "LTC"
    case DASH = "DASH"
}

enum Currency: String {
    case USD = "USD"
    case EUR = "EUR"
}

class CashInfoVM {
    //Save info to UserDefault
    func saveInfo(_ info: CashInfoModel) {
        let dataInfo: Data = try! JSONEncoder().encode(info)
        USER_DEFAULT.set(dataInfo, forKey: info.coinName)
        USER_DEFAULT.synchronize()
    }
    
    // load information from UserDefault
    func loadInfo(_ KeyInfo:String) -> CashInfoModel? {
        guard let dataInfo: Data = USER_DEFAULT.object(forKey: KeyInfo) as? Data else {
            return nil
        }
        
        let info: CashInfoModel? = try? JSONDecoder().decode(CashInfoModel.self, from: dataInfo)
        return info
    }
    
    //Calculate the total outcome
    func calculate(payment:Double, coinQuantity:Double, coinCurrentPrice:Double)-> Double {
        let total = (coinQuantity * coinCurrentPrice) - payment
        return total
    }
    
    func loadArray(_ KeyInfo:String) -> [Coin]? {
        guard let dataInfo: Data = USER_DEFAULT.object(forKey: KeyInfo) as? Data else {
            Log.error("Wrong")
            return nil
        }
        
        let info: [Coin]? = try? JSONDecoder().decode([Coin].self,from: dataInfo)
        return info
    }
    
    //Pass price to Enum
    func getPrice(by coin:Coin, complete:((_ price:String?)->())?) {
        switch coin {
        case .BTC:
            self.getPrice(url: URL_BTC_PRICE, complete: complete)
        case .ETH:
            self.getPrice(url: URL_ETH_PRICE, complete: complete)
        case .OTN:
            self.getPrice(url: URL_OTN_PRICE, complete: complete)
        case .NEO:
            self.getPrice(url: URL_NEO_PRICE, complete: complete)
        case .BCH:
            self.getPrice(url: URL_BCH_PRICE, complete: complete)
        case .ETC:
            self.getPrice(url: URL_ETC_PRICE, complete: complete)
        case .XRP:
            self.getPrice(url: URL_XRP_PRICE, complete: complete)
        case .DASH:
            self.getPrice(url: URL_DASH_PRICE, complete: complete)
        case .LTC:
            self.getPrice(url: URL_LTC_PRICE, complete: complete)
        }
    }
    
    //Get the price from Service
    private func getPrice(url:String, complete:((_ price:String?)-> ())?) {
        NetworkHelper.sharedInstance.get(url: url, complete: { (json, error) in
            if let json = json {
                Log.debug(json)
                if let complete = complete {
                    complete(String(json[Currency.USD.rawValue].double ?? 0.0))
                }
            } else {
                Log.error(error.debugDescription)
            }
        })
    }
}
