//
//  WebViewController.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/4/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit

protocol WebViewControllerDelegate: class {
    func goBack()
}

class WebViewController: BaseViewController {
    
    @IBOutlet weak var wbMain: UIWebView!
    var policyUrl = "_api/webview/security_policy"
    var termUrl = "_api/webview/terms_of_use"
    var isSignUp = false
    
    var mainUrl = ""
    
    weak var delegate: WebViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        wbMain.delegate = self
        self.loadWeb()
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
    }
    
    private func loadWeb() {
        if isSignUp {
            mainUrl = BASE_URL + termUrl
        } else {
            mainUrl = BASE_URL + policyUrl
        }
        let url = URL(string: mainUrl)
        var urlRequest = URLRequest(url: url!)
        guard let token = UserDefaultHelper.shared.userToken else { return }
        urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        wbMain.loadRequest(urlRequest)
    }
}

extension WebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        //        UIUtils.showLoading()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //        UIUtils.hideLoading()
    }
    
}
