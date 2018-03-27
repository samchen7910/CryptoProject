//
//  BarChartVM.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 3/18/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import Foundation
import Charts

class BarChartVM {
    
    func setBarChart(name:Array<Date>,value:Array<Double>,barChart:BarChartView){
        var dataArray:[BarChartDataEntry] = []
        for i in 0..<name.count {
            let data:BarChartDataEntry = BarChartDataEntry(x:Double(i),yValues: [value[i]])
            dataArray.append(data)
        }
        let dataset: BarChartDataSet = BarChartDataSet(values:dataArray, label: "Crypto")
        let dataChart:BarChartData = BarChartData(dataSet: dataset)
        dataset.setColor(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))
        
        barChart.data = dataChart
        barChart.chartDescription?.text = ""
        barChart.data?.setDrawValues(false)
        barChart.animate(xAxisDuration: 2.0,yAxisDuration: 2.0)
    }

    func weatherDatesFromCurrentDayMonth() -> [Date] {
        let now = Date()
        var currentDate = previousMonth(date: now)
        var datesArray = [Date]()
        
        while currentDate < now {
            datesArray.append(currentDate)
            currentDate = nextDay(date:currentDate)
        }
        print("result: \(datesArray)")
        return datesArray
    }
    
    func nextDay(date: Date) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        return Calendar.current.date(byAdding: dateComponents, to: date)!
    }
    
    func previousMonth(date: Date) -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -1
        return Calendar.current.date(byAdding: dateComponents, to: date)!
    }
    
    func getPrice30days(by coin:Coin, complete:((_ price:[Double]?)->())?) {
        switch coin {
        case .BTC:
            self.getPrice30days(url: URL_BTC_PRICE_30, complete: complete)
        case .ETH:
            self.getPrice30days(url: URL_ETH_PRICE_30, complete: complete)
        case .OTN:
            self.getPrice30days(url: URL_OTN_PRICE_30, complete: complete)
        case .NEO:
            self.getPrice30days(url: URL_NEO_PRICE_30, complete: complete)
        case .BCH:
            self.getPrice30days(url: URL_BCH_PRICE_30, complete: complete)
        case .ETC:
            self.getPrice30days(url: URL_ETC_PRICE_30, complete: complete)
        case .XRP:
            self.getPrice30days(url: URL_XRP_PRICE_30, complete: complete)
        case .DASH:
            self.getPrice30days(url: URL_DASH_PRICE_30, complete: complete)
        case .LTC:
            self.getPrice30days(url: URL_LTC_PRICE_30, complete: complete)
        }
    }
    
//    func getPrice30days(by list:[Double], complete:((_ price:[Double]?)->())?) {
//        self.getPrice30days(url: "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=29", complete: complete)
//    }
    
    private func getPrice30days(url:String, complete:((_ price:[Double]?)-> ())?) {
        NetworkHelper.sharedInstance.get(url: url, complete: { (json, error) in
            if let complete = complete {
                if let arrValue = json!["Data"].array {
                    let arrPrice = arrValue.map({ (dic) -> Double in
                        return dic["close"].double ?? 0.0
                    })
                    Log.debug(arrPrice)
                    complete(arrPrice)
                }
            }
        })
    }
    
}
