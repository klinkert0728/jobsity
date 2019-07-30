//
//  UIViewExtension.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius : CGFloat {
        set {
            layer.masksToBounds = true
            layer.cornerRadius =  newValue
        }
        get { return layer.cornerRadius}
    }
    
    @IBInspectable var borderWidth : CGFloat {
        set {layer.borderWidth = newValue}
        get { return layer.borderWidth}
    }
    
    @IBInspectable var borderColor : UIColor {
        set { layer.borderColor =  newValue.cgColor }
        get { return UIColor(cgColor: layer.borderColor!)}
    }
    
    func convertToImage() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size);
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return viewImage!
    }
}
