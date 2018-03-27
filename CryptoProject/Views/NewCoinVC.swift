//
//  NewCoinTableView.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 3/9/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import UIKit

class NewCoinVC: UIViewController {
    @IBOutlet weak var tbNewCoin: UITableView!
    
    private var vcMain: MainVC = MainVC()
    private var cashInfoVM: CashInfoVM = CashInfoVM()
    private var mainVM: MainVM = MainVM()
    
    
    var newCoinList: [Coin] = [.BTC,.NEO,.ETH,.OTN,.XRP,.ETC,.BCH,.LTC,.DASH] {
        didSet {
            self.tbNewCoin.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbNewCoin.dataSource = self
        self.tbNewCoin.delegate = self
        self.vcMain = self.navigationController?.viewControllers.first as! MainVC!
        self.mainVM.deleteCoin(vcMain.coinList, &self.newCoinList)
    }
}

extension NewCoinVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.vcMain.coinList.append(newCoinList[indexPath.row])
        
        //Save coinList to USER_DEFAULT
        self.mainVM.saveArray(self.vcMain.coinList)
        USER_DEFAULT.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        Log.debug("ADD SomeThing to CoinList")
        Log.debug(newCoinList.count)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
}

extension NewCoinVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newCoinList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCoinTableCell: NewCoinCell = tableView.dequeueReusableCell(withIdentifier: "newcoincell") as! NewCoinCell
        newCoinTableCell.lblCoin.text = newCoinList[indexPath.row].rawValue + " / \(Currency.USD.rawValue)"
        newCoinTableCell.imgCoin?.image = UIImage(named: newCoinList[indexPath.row].rawValue)
        
        return newCoinTableCell
    }
}
