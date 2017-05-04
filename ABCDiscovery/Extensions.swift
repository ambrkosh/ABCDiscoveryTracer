//
//  Extensions.swift
//  ABCDiscovery
//
//  Created by Ye David on 4/26/17.
//  Copyright © 2017 YeDavid. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    func setBorder(width: CGFloat, color: CGColor, cornerRadius: CGFloat?) -> Void {
        self.layer.borderWidth = width
        self.layer.borderColor = color
        self.layer.cornerRadius = cornerRadius ?? 5.0
    }
}

public extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
    
    func drawWithOptions(from: CGPoint, to: CGPoint, size: CGSize, strokeSize: CGFloat, strokeColor: CGColor) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.move(to: from)
        context?.addLine(to: to)
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineWidth(strokeSize)
        context?.setLineCap(CGLineCap.round)
        context?.setStrokeColor(strokeColor)
        context?.strokePath()
        
        let result: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    func drawTextWithOptions(rect: CGRect, text: NSString, font: String, fontSize: CGFloat, alpha: CGFloat) -> UIImage? {
        let textColor = UIColor.black.withAlphaComponent(alpha)
        let textFont = UIFont(name: font, size: fontSize)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ] as [String : Any]
        
        self.draw(in: CGRect(origin: CGPoint(x: rect.midX / 2, y: rect.midY / 2), size: rect.size))
        
        let rect = CGRect(origin: CGPoint(x: rect.midX / 2, y: rect.midY / 2), size: rect.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
