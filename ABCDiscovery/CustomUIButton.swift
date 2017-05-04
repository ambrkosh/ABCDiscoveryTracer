//
//  CustomUIButton.swift
//  ABCDiscovery
//
//  Created by Ye David on 4/26/17.
//  Copyright © 2017 YeDavid. All rights reserved.
//

import Foundation
import UIKit

public class CustomUIButton: UIButton {
    
    var image: UIImage?
    var title: String?
    
    public init(frame: CGRect, image: UIImage?, title: String?) {
        super.init(frame: frame)
        self.image = image
        self.title = title
        
        drawImage(img: self.image, title: self.title)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func drawImage(img: UIImage?, title: String?) {
        self.setBackgroundImage(UIImage(named: "MainItem.png"), for: UIControlState.normal)
        self.setImage(img ?? UIImage(), for: UIControlState.normal)
        self.setTitle(title ?? "", for: UIControlState.normal)
        self.setTitleColor(UIColor.black, for: UIControlState.normal)
        // self.layer.borderWidth = 1.0
        // self.layer.borderColor = UIColor.gray.cgColor
        // self.layer.cornerRadius = 5
    }
}
