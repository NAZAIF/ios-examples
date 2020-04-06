//
//  Hero.swift
//  Codable Tuts
//
//  Created by Moideen Nazaif VM on 13/06/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func getImageFrom(_ urlString: String, placeholder: UIImage) {
        image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            image = cachedImage
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.image = placeholder
                    }
                    print(error!.localizedDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = image
                }
                return
                }.resume()
        }
    }
}
