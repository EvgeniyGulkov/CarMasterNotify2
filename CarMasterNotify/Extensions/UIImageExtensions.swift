//
//  UIImageExtensions.swift
//  CarMasterNotify
//
//  Created by Admin on 10/10/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

extension UIImage {
    func scaleToSize(scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
