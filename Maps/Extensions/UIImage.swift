//
//  UIImage.swift
//  Maps
//
//  Created by Egor on 10/04/2019.
//  Copyright © 2019 Egor Markov. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func getSizedImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
