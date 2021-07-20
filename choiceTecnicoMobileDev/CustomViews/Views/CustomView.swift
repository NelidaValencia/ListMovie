//
//  CustomView.swift
//  choiceTecnicoMobileDev
//
//  Created by Nelida Valencia on 18/07/21.
//

import UIKit

@IBDesignable
class CustomView: UIControl {
    
    @IBInspectable open var borderRadius:CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.borderRadius
        }
    }
    
    @IBInspectable open var borderColor:UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable open var borderWidth:CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
}

