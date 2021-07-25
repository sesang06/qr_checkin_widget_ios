//
//  CookieSaver.swift
//  qrcheckin
//
//  Created by sesang on 2021/07/23.
//

import Foundation

class CookieSaver {
    
    let userDefaults = UserDefaults(suiteName: "group.sesang06")
    
    let url = URL(string: "https://nid.naver.com/login/privacyQR")!
    
    func save() {
        
        if let cookies = HTTPCookieStorage.shared.cookies(for: url) {
            for cookie in cookies {
                if cookie.name == "NID_AUT" {
                    userDefaults?.setValue(cookie.value, forKey: "NID_AUT")
                }
                
                if cookie.name == "NID_SES" {
                    userDefaults?.setValue(cookie.value, forKey: "NID_SES")
                }
            }
            
        }
        
    }
    
    func load() {
        
        if let aut = userDefaults?.string(forKey: "NID_AUT") {
            if let cookie = HTTPCookie(properties: [
                .name: "NID_AUT",
                .domain: ".nid.naver.com",
                .value: aut,
                .path: "/"
            ]) {
                
                HTTPCookieStorage.shared.setCookie(cookie)
                
            }
        }
        
        if let ses = userDefaults?.string(forKey: "NID_SES") {
            if let cookie = HTTPCookie(properties: [
                .name: "NID_SES",
                .domain: ".nid.naver.com",
                .value: ses,
                .path: "/"
            ]) {
                
                HTTPCookieStorage.shared.setCookie(cookie)
                
            }
        }
        
    }
    
}
