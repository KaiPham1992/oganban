//
//  MySellingViewController.swift
//  Oganban
//
//  Created Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit


protocol MySellingViewControllerDelegate: class {
    func gotoLogin()
    func gotoMySellExpired()
}

class MySellingViewController: BaseViewController {

    @IBOutlet weak var vContain: UIView!
    @IBOutlet weak var lbTotalPosted: UILabel!
    @IBOutlet weak var lbTotalSubPost: UILabel!
    @IBOutlet weak var vCheckLogin: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var tbMySelling: UITableView!
    
	var presenter: MySellingPresenterProtocol?

    var parrentNavigation: UINavigationController?
    weak var delegate: MySellingViewControllerDelegate?
    var refeshControl: UIRefreshControl?
    var isCanLoadMore: Bool = false
    
    var listRecord: BaseRecordEntity? {
        didSet {
            tbMySelling.reloadData()
            
            if let count = self.listRecord?.dataRecord, count.isEmpty  {
                tbMySelling.isHidden = true
                showNoData()
            } else {
                hideNoData()
            }
            
            lbTotalPosted.text = "Tin đã đăng: \(listRecord?.allowShow ?? 0)"
            lbTotalSubPost.text = "Tin cho phép đăng: \(listRecord?.allowNews ?? 0)"
        }
    }
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkLogin()
    }
    
    func setupView() {
        btnLogin.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: 20)
        vContain.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: 10)
        
        configTable()
        
        refeshControl = UIRefreshControl()
        refeshControl?.addTarget(self, action: #selector(self.refeshData), for: .valueChanged)
        tbMySelling.addSubview(refeshControl!)
    }
    
    func checkLogin() {
        if UserDefaultHelper.shared.isLoggedIn {
            vCheckLogin.isHidden = true
            getData()
        } else {
            vCheckLogin.isHidden = false
        }
    }
    
    func configTable() {
        tbMySelling.dataSource = self
        tbMySelling.delegate = self
        
        tbMySelling.registerTableCell(MySellingCell.self)
//        tbMySelling.separatorStyle = .none
        tbMySelling.contentInset.bottom = 10
        tbMySelling.tableFooterView = UIView()
    }
    
    func getData() {
        presenter?.getRecordSellerPost(status: "show", offset: 0, limit: 10)
    }
    
    @objc private func refeshData() {
        getData()
        refeshControl?.endRefreshing()
    }
    
    @IBAction func btnExpired() {
        delegate?.gotoMySellExpired()
    }
    
    @IBAction func login() {
        delegate?.gotoLogin()
    }
    
    
}

extension MySellingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = listRecord?.dataRecord.count else { return 0}

        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(MySellingCell.self)
        cell.vRecordSelling.record = listRecord?.dataRecord[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderDetailRouter.createModule()
        parrentNavigation?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = listRecord?.dataRecord.count else { return }
        if isCanLoadMore &&  count >= 20 {
            if indexPath.item == count - 10 {
                isCanLoadMore = false
                presenter?.getRecordSellerPost(status: "show", offset: count, limit: 20)
            }
        }
    }
}

extension MySellingViewController: MySellingViewProtocol {
    
    func didGetRecordSellerPost(listRecord: BaseRecordEntity?) {
        self.listRecord = listRecord
    }
    
    func didGetRecordSellerPost(error: APIError?) {
        print("ERROR .....")
    }
    
    
}
