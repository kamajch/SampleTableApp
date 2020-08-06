//
//  UIImage+Extension.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 06/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(urlString: String) -> URLSessionTask? {
        let imageCache = NSCache<NSString, UIImage>()
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return nil
        }
        
        guard let url = URL(string: urlString) else { return nil }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            imageCache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
        return task
    }
}
