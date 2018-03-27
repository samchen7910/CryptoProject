//
//  CoinListVM.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 3/11/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import Foundation

class CoinListVM {
    func saveInfoArray(_ info:[Coin]){
        let dataInfo: Data = try! JSONEncoder().encode(info)
        USER_DEFAULT.set(dataInfo, forKey: COIN_LIST)
        USER_DEFAULT.synchronize()
    }
    
    func loadInfoArray(_ KeyInfo:String) -> [Coin]? {
        guard let dataInfo: Data = USER_DEFAULT.object(forKey: KeyInfo) as? Data else {
            return nil
        }
        
        let info: [Coin]? = try? JSONDecoder().decode([Coin].self, from:dataInfo)
        
        return info 
    }
}
