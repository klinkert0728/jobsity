//
//  UIimageExtension.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/30/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    
    func imageWithTintColor(color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context.fill(rect)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage
        
    }
    
    
    class func image(named name:String, tintColor: UIColor) -> UIImage {
        let image: UIImage = UIImage(named: name)!
        return image.imageWithTintColor(color: tintColor)
    }
}
