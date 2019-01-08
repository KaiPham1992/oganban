//
//  NotificationViewController.swift
//  RedStar
//
//  Created Ngoc Duong on 12/13/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NotificationViewController: BaseViewController {
    
    var presenter: NotificationPresenterProtocol?
    @IBOutlet weak var tbNotification: UITableView!
    var refreshControl:  UIRefreshControl!
    var canLoadMore = false
    var isRefresh = false
    
    var listNotification = [NotificationEntity]() {
        didSet {
            tbNotification.reloadData()
            if self.listNotification.isEmpty {
                tbNotification.isHidden = true
                showNoData()
            } else {
                hideNoData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getNotification(offset: 0)
        DataManager.shared.getNotificationCount { (count) in
            if let tabItems = self.tabBarController?.tabBar.items {
                let tabItem = tabItems[3]
                if count == 0 {
                    tabItem.badgeValue = nil
                } else {
                    tabItem.badgeValue = "\(count)"
                }
            }
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        //        addButtonTextToNavigation(title: TitleString.markReadAll, style: .right, action: #selector(btnMarkReadAllTapped))
        setTitleNavigation(title: TitleString.notification)
    }
    
    
    
    @objc func btnMarkReadAllTapped() {
        
    }
}

extension NotificationViewController: NotificationViewProtocol {
    func didGetNotification(notifications: ParentNotificationEntity?) {
        canLoadMore = false
        guard let _notifications = notifications?.notifications else { return }
        canLoadMore = _notifications.count == limitLoad
        
        if self.listNotification.isEmpty || isRefresh {
            isRefresh = false
            self.listNotification = _notifications
        } else {
            self.listNotification.append(contentsOf: _notifications)
        }
        
    }
    
    func didGetError(error: APIError?) {
        canLoadMore = false
        self.listNotification = []
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbNotification.separatorStyle = .none
        tbNotification.registerXibFile(NotificationCell.self)
        
        tbNotification.estimatedRowHeight = 150
        tbNotification.rowHeight = UITableView.automaticDimension
        
        tbNotification.delegate = self
        tbNotification.dataSource = self
        tbNotification.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tbNotification.addSubview(refreshControl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(NotificationCell.self, for: indexPath)
        cell.notification = self.listNotification[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if canLoadMore && indexPath.item == self.listNotification.count - 5 {
            presenter?.getNotification(offset: self.listNotification.count)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noti = self.listNotification[indexPath.item]
        noti.isRead = true
        noti.isReadString = "1"
        presenter?.readNotification(id: noti.id&)
        
        let vc = NotificationDetailRouter.createModule(notification: noti)
        self.push(controller: vc)
    }
    
    @objc func pullToRefresh() {
        isRefresh = true
        self.refreshControl.endRefreshing()
        presenter?.getNotification(offset: 0)
    }
    
}


