//
//  ImageModelCacheManager.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 30.05.2024.
//

import Foundation
import SwiftUI

class ImageModelCacheManager {
    
    static let instance: ImageModelCacheManager = ImageModelCacheManager()
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        imageCache.setObject(value, forKey: key as NSString)
    }
    func get(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
