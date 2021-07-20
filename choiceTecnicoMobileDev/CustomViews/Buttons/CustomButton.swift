//
//  CustomButton.swift
//  choiceTecnicoMobileDev
//
//  Created by Nelida Valencia on 18/07/21.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    var padLeft:CGFloat = 0.0;
    var padRight:CGFloat = 0.0;
    var padTop:CGFloat = 0.0;
    var padBottom:CGFloat = 0.0;
    
    @IBInspectable open var paddingLeft:CGFloat = 0.0 {
        didSet {
            self.padLeft = self.paddingLeft
        }
    }
    
    @IBInspectable open var paddingRight:CGFloat = 0.0 {
        didSet {
            self.padRight = self.paddingRight
        }
    }
    
    @IBInspectable open var paddingTop:CGFloat = 0.0 {
        didSet {
            self.padTop = self.paddingTop
        }
    }
    
    @IBInspectable open var paddingBottom:CGFloat = 0.0 {
        didSet {
            self.padBottom = self.paddingBottom
        }
    }
    
    @IBInspectable open var borderColor:UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable open var borderRadius:CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.borderRadius
        }
    }
    
    @IBInspectable open var borderWidth:CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    override func contentRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: self.padTop, left: self.padLeft, bottom: self.padBottom, right: self.padRight))
    }
    
    @IBInspectable open var SubRaya:Bool = false{
        didSet {
            let attributeString = NSAttributedString(string: self.titleLabel?.text ?? "", attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            self.setAttributedTitle(attributeString, for: .normal)
        }
    }
    
}

