//
//  UIColorExtensions.swift
//  CarMasterNotify
//
//  Created by Admin on 10.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
