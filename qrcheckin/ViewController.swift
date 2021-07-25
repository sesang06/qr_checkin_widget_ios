//
//  ViewController.swift
//  qrcheckin
//
//  Created by sesang on 2021/07/21.
//

import UIKit

import SwiftSoup
class ViewController: UIViewController {

    static let shared = ViewController()
    
    let url = URL(string: "https://nid.naver.com/login/privacyQR")
    
    let webview = WKCookieWebView(frame: .zero)

    override func loadView() {
        view = webview
    }
    
    let cookieSaver = CookieSaver()
    override func viewDidLoad() {
         super.viewDidLoad()
         
        webview.load(URLRequest(url: url!))
        cookieSaver.save()
     }

}

