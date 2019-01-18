//
//  WebViewController.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/4/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: class {
    func goBack()
}

class WebViewController: BaseViewController {
    
    @IBOutlet weak var wkMain: WKWebView!
    var policyUrl = "_api/webview/security_policy"
    var termUrl = "_api/webview/terms_of_use"
    var isTermsOfUse = true
    var isPush = true
    var mainUrl = ""
    
    weak var delegate: WebViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        wkMain.navigationDelegate = self
        self.loadWeb()
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addButtonToNavigation(image: AppImage.imgBack, style: .left, action: #selector(self.tapBackButton))
    }
    
    @objc func tapBackButton(){
        if isPush {
            self.pop(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    private func loadWeb() {
        if isTermsOfUse {
            mainUrl = BASE_URL + termUrl
        } else {
            mainUrl = BASE_URL + policyUrl
        }
        if let url = URL(string: mainUrl) {
            let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
            
            ProgressView.shared.show()
            wkMain.load(urlRequest)
        }
    }
}

extension WebViewController: WKNavigationDelegate {
   
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         ProgressView.shared.hide()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        ProgressView.shared.hide()
    }
}

