//
//  MainVM.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 3/15/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import Foundation

class MainVM {
    func deleteCoin(_ coinList : [Coin],_ newCoinList: inout [Coin]) {
        Log.debug("Delete Coin")
        newCoinList = newCoinList.filter { (coin) -> Bool in
            return !coinList.contains(coin)
        }
    }
    
    func saveArray(_ info: [Coin]) {
        let dataInfo: Data = try! JSONEncoder().encode(info)
        USER_DEFAULT.set(dataInfo, forKey: "array")
        USER_DEFAULT.synchronize()
    }
}
