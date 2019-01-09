//
//  HistoryCoinViewController.swift
//  Oganban
//
//  Created Kent on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryCoinViewController: BaseViewController {
    
    var presenter: HistoryCoinPresenterProtocol?
    
    @IBOutlet weak var tvHistory: UITableView!
    @IBOutlet weak var totalCoin: UILabel!
    var refreshControl:  UIRefreshControl!
    var canLoadMore = false
    var isRefresh = false
    
    var historyList = [HistoryCoinEntity]() {
        didSet {
            tvHistory.reloadData()
            if self.historyList.isEmpty {
                tvHistory.isHidden = true
                showNoData()
            } else {
                hideNoData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackToNavigation(icon: AppImage.imgWhiteBack)
        self.setTitleNavigation(title: NavigationTitle.historyCoin)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pullToRefresh()
    }
    
    func configureTableView() {
        tvHistory.dataSource = self
        tvHistory.delegate = self
        tvHistory.registerXibFile(HistoryCoinCell.self)
        tvHistory.tableFooterView = UIView()
        tvHistory.estimatedRowHeight = 100
        tvHistory.translatesAutoresizingMaskIntoConstraints = false
        tvHistory.rowHeight = UITableView.automaticDimension
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tvHistory.addSubview(refreshControl)
    }
    
    @objc func pullToRefresh() {
        isRefresh = true
        self.refreshControl.endRefreshing()
        self.presenter?.getHistoryCoin(offset: 0)
        self.showTotalCoin(total: 10000.0)
    }
    
    func showTotalCoin(total: Double){
        if let coin = String(total).addComma() {
            totalCoin.text = coin  + " ơ"
        } else {
            totalCoin.text = "0 ơ"
        }
    }
}
extension HistoryCoinViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(HistoryCoinCell.self, for: indexPath) as HistoryCoinCell
        cell.showData(history: historyList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if canLoadMore && indexPath.item == self.historyList.count - 5 {
            presenter?.getHistoryCoin(offset: self.historyList.count)
        }
    }
}

extension HistoryCoinViewController: HistoryCoinViewProtocol{
    
    func getSucessHistoryCoin(history: BaseHistoryCoinEntity?) {
        canLoadMore = false
        guard let historyCoin = history else { return }
        canLoadMore = historyCoin.dataCoin.count == limitLoad
        
        if self.historyList.isEmpty || isRefresh {
            isRefresh = false
            self.historyList = historyCoin.dataCoin
        } else {
            self.historyList.append(contentsOf: historyCoin.dataCoin)
        }
        
        self.showTotalCoin( historyCoin.accountCoin )
    }
    
    func showTotalCoin(_ totalCoin: Double?) {
        if let _coin = totalCoin, let coin = String(_coin).addComma() {
            let attr = NSMutableAttributedString()
            let attr1 = (coin + " ").toAttributedString(color: AppColor.black414141, font: AppFont.fontBoldRoboto15, isUnderLine: false)
            let attr2 = "ơ".toAttributedString(color: AppColor.black414141, font: AppFont.fontBoldRoboto15, isUnderLine: true)
            attr.append(attr1)
            attr.append(attr2)
            self.totalCoin.attributedText = attr
        }
    }
    func getErrorHistoryCoin(error: APIError?) {
        canLoadMore = false
        self.historyList = []
    }
}
