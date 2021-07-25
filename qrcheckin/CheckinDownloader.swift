//
//  CheckinDownloader.swift
//  qrcheckin
//
//  Created by sesang on 2021/07/23.
//

import Foundation
import UIKit

class CheckinDownloader {
    let url = URL(string: "https://nid.naver.com/login/privacyQR")!
 
    
    func fetchUIImage() -> UIImage? {
        CookieSaver().load()
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        let text = String(decoding: data, as: UTF8.self)
        let loader = ImageCheckinLoader(text: text)
        guard let base64ImageString = loader.parseImageData() else {
            return nil
        }
        guard let base64ImageData = Data(base64Encoded: base64ImageString, options: NSData.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        return UIImage(data: base64ImageData)
    }
}
