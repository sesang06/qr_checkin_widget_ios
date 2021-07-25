//
//  ImageCheckInLoader.swift
//  qrcheckin
//
//  Created by sesang on 2021/07/23.
//

import Foundation

class ImageCheckinLoader {
    
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    
    
    func parseImageData() -> String? {
        print(text)
        guard let imageTag = self.getTagById(id: "qrImage") else {
            return nil
        }
        guard let source = self.getValueByProperty(tag: imageTag, property: "src") else {
            return nil
        }
        let prefix = "data:image/jpeg;base64, "
    
        return source.replacingOccurrences(of: prefix, with: "")
        
    }
    
    
    func getTagById(id: String) -> String? {
        if let range = text.range(of: "id=\"\(id)\"") {
            var lowerBound = range.lowerBound
            var upperBound = range.upperBound
            
            if upperBound == text.endIndex {
                return nil
            }
            
            while (lowerBound >= text.startIndex && text[lowerBound] != "<") {
                if lowerBound == text.startIndex {
                    return nil
                }
                lowerBound = text.index(before: lowerBound)
                
            }
      
            while (upperBound < text.endIndex && text[upperBound] != ">") {
                upperBound = text.index(after: upperBound)
                if upperBound == text.endIndex {
                    return nil
                }
            }
            
            let wholeTag = text[lowerBound...upperBound]
            return String(wholeTag)
        } else {
            return nil
        }
    }
    
    
    func getValueByProperty(tag: String, property: String) -> String? {
        if let range = tag.range(of: "\(property)=") {
            let findStart = range.lowerBound
            if findStart == tag.endIndex {
                return nil
            }
            let searchedTag = tag[tag.index(after: findStart)..<tag.endIndex]
            
            var startIndex: Int?
            var endIndex: Int?
            for (index, value) in searchedTag.enumerated() {
                if value == "\"" {
                    if startIndex == nil {
                        startIndex = index
                    } else if endIndex == nil {
                        endIndex = index
                        break
                    }
                }
            }
            guard let startIndex = startIndex, let endIndex = endIndex else {
                return nil
            }
            if (endIndex - startIndex == 1) {
                return nil
            }
            let source = searchedTag[searchedTag.index(searchedTag.startIndex, offsetBy: startIndex+1)..<searchedTag.index(searchedTag.startIndex, offsetBy: endIndex)]
            return String(source)
            
        } else {
            return nil
        }
    }
}
