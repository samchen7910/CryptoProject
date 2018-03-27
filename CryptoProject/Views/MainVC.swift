//
//  TableView.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 3/4/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    var coinList: [Coin] = [] {
        didSet {
            self.tbName.reloadData()
        }
    }
    
    private var cashInfoVM: CashInfoVM = CashInfoVM()
    private var mainVM: MainVM = MainVM()
    
    @IBOutlet weak var tbName: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbName.dataSource = self
        self.tbName.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load CoinList from UserDefault
        self.coinList = cashInfoVM.loadArray("array") ?? []
    }
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell:MainCell = tableView.dequeueReusableCell(withIdentifier: "table_cell") as! MainCell
        tableCell.lblCoinName.text = coinList[indexPath.row].rawValue
        tableCell.imgCoin?.image = UIImage(named: coinList[indexPath.row].rawValue)
        
        cashInfoVM.getPrice(by: coinList[indexPath.row]) { (price) in
            tableCell.lblCoinPrice.text = price
        }
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinList.count
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcCashInfo = storyboard?.instantiateViewController(withIdentifier: "CashInfoVC") as! CashInfoVC
        vcCashInfo.textData = coinList[indexPath.row]
        self.navigationController?.pushViewController(vcCashInfo, animated: true)
        
        Log.debug(vcCashInfo.textData)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            coinList.remove(at: indexPath.row)
            
            // Save CoinList to Userdefault after removed
            self.mainVM.saveArray(coinList)
            USER_DEFAULT.synchronize()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
}



