//
//  UIView+.swift
//  Golfull
//
//  Created by Hồ Sĩ Tuấn on 29/07/2021.
//

import Foundation
import UIKit
extension UIView {
    
    @discardableResult
    public func addSubviews(_ subviews: UIView...) -> UIView {
        subviews.forEach { addSubview($0) }
        return self
    }
    
    @discardableResult
    public func addSubViews(_ subviews: [UIView]) -> UIView {
        subviews.forEach { addSubview($0) }
        return self
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: (layer.borderColor ?? UIColor.clear.cgColor))
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderShadow: UIColor {
        get {
            return UIColor(cgColor: (layer.shadowColor ?? UIColor.clear.cgColor))
        }
        set {
            layer.shadowColor = newValue.cgColor
            layer.shadowOpacity = 0.3
            layer.shadowOffset = CGSize(width: 4, height: 4)
            layer.shadowRadius = 2
        }
    }
    
    @discardableResult
    func putShadow(
        shadowColor: UIColor,
        radius: CGFloat,
        offset: CGSize, opacity: Float) -> UIView {
        
        var shadowFrame = CGRect.zero // Modify this if needed
        shadowFrame.size.width = 0.0
        shadowFrame.size.height = 0.0
        shadowFrame.origin.x = 0.0
        shadowFrame.origin.y = 0.0
        
        let shadow = UIView(frame: shadowFrame)
        shadow.isUserInteractionEnabled = false
        shadow.layer.shadowColor = shadowColor.cgColor
        shadow.layer.shadowOffset = offset
        shadow.layer.shadowRadius = radius
        shadow.layer.masksToBounds = false
        shadow.clipsToBounds = false
        shadow.layer.shadowOpacity = opacity
        
        if offset != .zero {
            let shadowRect: CGRect = self.bounds.insetBy(dx: 0, dy: 4)
            self.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
        }
        
        self.superview?.insertSubview(shadow, belowSubview: self)
        shadow.addSubview(self)
        return shadow
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    class func emptyView(_ bgColor: UIColor? = nil) -> UIView {
        let v = UIView()
        v.backgroundColor = bgColor ?? .clear
        v.isUserInteractionEnabled = false
        return v
    }
    
    class func dashView(size: CGSize, color: UIColor) -> UIView {
        let v = UIView()
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4, 4]
        let path = CGMutablePath()
        if size.width > size.height{
            path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: size.width, y: 0)])
        }else{
            path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: size.height)])
        }
        shapeLayer.path = path
        v.layer.addSublayer(shapeLayer)
        return v
    }
    
    class func spaceView(height: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        return view
    }
}

extension UIView {
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

extension UIView {
    func setGradientBackground(colors: [UIColor: CGFloat]) {
        var cgColors = [CGColor]()
        var location = [NSNumber]()
        for color in colors {
            cgColors.append(color.key.cgColor)
            location.append(NSNumber(value: Float(color.value)))
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = cgColors
        gradientLayer.locations = location
        gradientLayer.frame = UIScreen.main.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = .clear
        
    }
}
