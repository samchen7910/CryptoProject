//
//  CashInfoVC.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 2/26/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import UIKit
import Charts

class CashInfoVC: UIViewController {
    @IBOutlet weak var txtPayment: UITextField!
    @IBOutlet weak var txtPPrice: UITextField!
    @IBOutlet weak var txtQty: UITextField!
    @IBOutlet weak var txtTCoin: UITextField!
    @IBOutlet weak var lbBenefit: UILabel!
    @IBOutlet weak var viewBarChart: BarChartView!
    
    
    private var cashInfoVM: CashInfoVM = CashInfoVM()
    private var barChartVM: BarChartVM = BarChartVM()
    
    //This variable to save the data from CashInfoVC
    var textData: Coin = .BTC
    private var price30days:[Double] = []
    private var history30days:[Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.debug(textData)
        
        self.title = textData.rawValue
        history30days = self.barChartVM.weatherDatesFromCurrentDayMonth()
        //Show loading
        HUDHelper.sharedInstance.showLoading(view: self.view)
        cashInfoVM.getPrice(by: textData) { (price) in
            self.txtTCoin.text = price
            HUDHelper.sharedInstance.hideLoading()
        }
        barChartVM.getPrice30days(by: textData) { (price) in
            self.price30days = price!
            self.barChartVM.setBarChart(name: self.history30days, value: self.price30days, barChart: self.viewBarChart)
            
        }
            
     
        if let info: CashInfoModel = self.cashInfoVM.loadInfo(textData.rawValue) {
            Log.debug("Load something")
            self.txtPayment.text = String(info.payment)
            self.txtPPrice.text = String(info.coinPrice)
            self.txtQty.text = String(info.coinQuantity)
            self.lbBenefit.text = String(info.benefit)
        }
        
    }
    
    @IBAction func tapCalculate(_ sender: Any) {
        if self.checkValid() == false {
            return
        }
        
        self.lbBenefit.text = String(self.cashInfoVM.calculate(payment: Double(self.txtPayment.text!)!,
                                                               coinQuantity: Double(self.txtQty.text!)!,
                                                               coinCurrentPrice: Double(self.txtTCoin.text!)!))
        let info: CashInfoModel = CashInfoModel(payment: Double(self.txtPayment.text!)!,
                              coinPrice: Double(self.txtPPrice.text!)!,
                              coinQuantity: Double(self.txtQty.text!)!,
                              coinName:textData.rawValue,
                              benefit:Double(self.lbBenefit.text!)!)
        Log.debug("Save cash info")
        self.cashInfoVM.saveInfo(info)
    }
    
    //To check the fields 
    private func checkValid() -> Bool {
        guard let payment = self.txtPayment.text, payment != "", payment.isStringAnInt() else {
            Commons.shareInstance.showAlertOnViewController(self, message: "Payment should not be empty", mainButton: "OK", mainComplete: { _ in
            })
            return false
        }
        
        guard let pPrice = self.txtPPrice.text, pPrice != "", pPrice.isStringAnInt() else {
            Commons.shareInstance.showAlertOnViewController(self, message: "Purchase should not be empty", mainButton: "OK", mainComplete: { _ in
            })
            return false
        }
        
        guard let quantity = self.txtQty.text, quantity != "", quantity.isStringAnInt() else {
            Commons.shareInstance.showAlertOnViewController(self, message: "Quantity should not be empty", mainButton: "OK", mainComplete: { _ in
            })
            return false
        }
        
        guard let tCoin = self.txtTCoin.text, tCoin != "" else {
            Commons.shareInstance.showAlertOnViewController(self, message: "TCoin should not be empty", mainButton: "OK", mainComplete: { _ in
            })
            return false
        }
        
        return true
    }
}


