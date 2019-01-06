//
//  HistoryCoinViewController.swift
//  Oganban
//
//  Created Admin on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryCoinViewController: BaseViewController, HistoryCoinViewProtocol {

    @IBOutlet weak var tvHistory: UITableView!
    var historyList = ["1","2","3","4","5"]
    
    var presenter: HistoryCoinPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackToNavigation(icon: AppImage.imgWhiteBack)
        self.setTitleNavigation(title: NavigationTitle.historyCoin)
        registerTableView()
    }

    func registerTableView() {
        tvHistory.dataSource = self
        tvHistory.delegate = self
        tvHistory.registerXibFile(HistoryCoinCell.self)
        tvHistory.tableFooterView = UIView()
    }
}
extension HistoryCoinViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(HistoryCoinCell.self, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}