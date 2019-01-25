
import UIKit

let imageCache = NSCache<AnyObject, AnyObject> ()

extension UIImageView {
    func cacheImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
        }.resume()
    }
}

