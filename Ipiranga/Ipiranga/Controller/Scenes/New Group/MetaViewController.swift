//
//  MetaViewController.swift
//  Ipiranga
//
//  Created by Maurício Mazzocco on 08/12/18.
//  Copyright © 2018 Totvs. All rights reserved.
//

import UIKit
import RSLoadingView
import WebKit

class MetaViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    let api = FluigAPI()
    let loadingView = RSLoadingView()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        loadingView.showOnKeyWindow()
        webView.load(api.generateUrlRequest(urlString: "/portal/p/ipiranga/meta"))

        
    }
    override func viewDidAppear(_ animated: Bool) {


    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.hide()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
