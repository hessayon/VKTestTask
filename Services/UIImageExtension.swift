//
//  UIImageExtension.swift
//  Services
//
//  Created by Margo Naumenko on 13.07.2022.
//

import UIKit
    
extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}
