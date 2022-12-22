//
//  CacheService.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/21/22.
//

import Foundation
import SwiftUI

class CacheService {
    
    // Stores the image components with URL string as key
   static private var imageCache = [String: Image]()
    
    // Return Image for given key. Nil means image doesn't exist in cache
   static func getImage(forKey: String) -> Image? {
        return imageCache[forKey]
    }
    // stores the image component in cache with given key
    static func setImage(image: Image, forKey: String) {
        imageCache[forKey] = image
    }
}
