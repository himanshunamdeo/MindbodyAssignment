//
//  LazyImageView.swift
//  MindbodyAssignment
//
//  Created by MeTaLlOiD on 04/04/22.
//

import UIKit

// Lazy Loading image view with cacheing mechanism
class LazyImageView: UIImageView {
    
    // Image will be cached in here
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    // This will prepare a URL with the country name provided and will fetch image of the country
    func loadExternalImage(countryName: String) {
        let url = flagsURL.appending(countryName)
        
        //If the Image is already cached than it will be used
        if let cachedImage = imageCache.object(forKey: url as AnyObject) {
            self.image = cachedImage
            return
        }
        
        //If image is not found in the Cache it will be downloaded and cached for later use
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if error == nil {
                if response != nil {
                    if let data = data {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.imageCache.setObject(image, forKey: url as AnyObject)
                                self.image = image
                            }
                        }
                    }
                }
            }
        }.resume()
    }
}
