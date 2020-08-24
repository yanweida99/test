//
//  WebViewController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private var url: String = ""
    
    convenience init(url: String = "") {
        self.init()
        self.url = url
    }
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.load(URLRequest.init(url: URL.init(string: self.url)!))
    }
}

