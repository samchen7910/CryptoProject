//
//  CashInfoModel.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 2/26/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import Foundation

class CashInfoModel: Codable {
    var payment: Double
    var coinPrice: Double
    var coinQuantity: Double
    var coinName: String
    var benefit:Double
    
    init(payment:Double, coinPrice: Double, coinQuantity: Double, coinName: String,benefit:Double) {
        self.payment = payment
        self.coinPrice = coinPrice
        self.coinQuantity = coinQuantity
        self.coinName = coinName
        self.benefit = benefit
    }
}
