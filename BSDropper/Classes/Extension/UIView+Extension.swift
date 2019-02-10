//
//  UIView+Extension.swift
//  BSDropper
//
//  Created by Seoksoon Jang on 10/02/2019.
//  Copyright © 2019 JSS. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func dropShadow(shadowColor: CGColor = UIColor.black.cgColor, strength: CGFloat = 1.0) {
    self.layer.shadowColor = shadowColor
    self.layer.shadowRadius = strength
    self.layer.shadowOpacity = Float(strength)
    self.layer.shadowOffset = CGSize(width: strength, height: strength)
    self.layer.masksToBounds = false
  }
}

extension UIView {
  func setX(x:CGFloat) {
    let yPosition = self.frame.origin.y
    let height = self.frame.height
    let width = self.frame.width
    self.frame = CGRect(x: x, y: yPosition, width: width, height: height)
  }
}

extension UIView {
  func slideX(x:CGFloat, duration: Double) {
    let yPosition = self.frame.origin.y
    
    let height = self.frame.height
    let width = self.frame.width
    
    self.frame = CGRect(x: x, y: yPosition, width: width, height: height)
  }
  
  func slideY(y:CGFloat, duration: Double) {
    let xPosition = self.frame.origin.x
    
    let height = self.frame.height
    let width = self.frame.width
    
    self.frame = CGRect(x: xPosition, y: y, width: width, height: height)
  }
}

extension UIView {
  // 곡선 원형 UI 만들기
  func makeCircular() {
    self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
    self.clipsToBounds = true
  }
  
  // 원형 UI 만들기
  func makeRightCircular(circleBorderColor: UIColor = UIColor.white245) {
    self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0 // self.frame.size.width / 2;
    self.layer.masksToBounds = true
    self.clipsToBounds = true
    self.contentMode = .scaleAspectFill
    
    self.layer.borderColor = circleBorderColor.cgColor
    self.layer.borderWidth = 1.0
  }
}

extension UIView {
  func addFullLineTopBorderWithColor(color: UIColor, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: width)
    self.layer.addSublayer(border)
  }
  
  func addTopBorderWithColor(color: UIColor, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
    self.layer.addSublayer(border)
  }
  
  func addRightBorderWithColor(color: UIColor, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
    self.layer.addSublayer(border)
  }
  
  func addBottomBorderWithColor(color: UIColor, width: CGFloat, frameWidthOffset: CGFloat = 0.0) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(x: 0,
                          y: self.frame.size.height - width,
                          width: self.frame.size.width - frameWidthOffset,
                          height: width)
    self.layer.addSublayer(border)
  }
  
  func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
    self.layer.addSublayer(border)
  }
}

@IBDesignable
public extension UIView {
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
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
  
  @IBInspectable var borderColor: UIColor? {
    get {
      return UIColor(cgColor: layer.borderColor!)
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
}

@IBDesignable
extension UIView {
  
  @IBInspectable
  /// Should the corner be as circle
  public var circleCorner: Bool {
    get {
      return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
    }
    set {
      cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
    }
  }
  
  @IBInspectable
  /// Shadow color of view; also inspectable from Storyboard.
  public var shadowColor: UIColor? {
    get {
      guard let color = layer.shadowColor else {
        return nil
      }
      return UIColor(cgColor: color)
    }
    set {
      layer.shadowColor = newValue?.cgColor
    }
  }
  
  @IBInspectable
  /// Shadow offset of view; also inspectable from Storyboard.
  public var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  /// Shadow opacity of view; also inspectable from Storyboard.
  public var shadowOpacity: Double {
    get {
      return Double(layer.shadowOpacity)
    }
    set {
      layer.shadowOpacity = Float(newValue)
    }
  }
  
  @IBInspectable
  /// Shadow radius of view; also inspectable from Storyboard.
  public var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable
  /// Shadow path of view; also inspectable from Storyboard.
  public var shadowPath: CGPath? {
    get {
      return layer.shadowPath
    }
    set {
      layer.shadowPath = newValue
    }
  }
  
  @IBInspectable
  /// Should shadow rasterize of view; also inspectable from Storyboard.
  /// cache the rendered shadow so that it doesn't need to be redrawn
  public var shadowShouldRasterize: Bool {
    get {
      return layer.shouldRasterize
    }
    set {
      layer.shouldRasterize = newValue
    }
  }
  
  @IBInspectable
  /// Should shadow rasterize of view; also inspectable from Storyboard.
  /// cache the rendered shadow so that it doesn't need to be redrawn
  public var shadowRasterizationScale: CGFloat {
    get {
      return layer.rasterizationScale
    }
    set {
      layer.rasterizationScale = newValue
    }
  }
  
  @IBInspectable
  /// Corner radius of view; also inspectable from Storyboard.
  public var maskToBounds: Bool {
    get {
      return layer.masksToBounds
    }
    set {
      layer.masksToBounds = newValue
    }
  }
}


// MARK: - Properties

public extension UIView {
  
  /// Size of view.
  public var size: CGSize {
    get {
      return self.frame.size
    }
    set {
      self.width = newValue.width
      self.height = newValue.height
    }
  }
  
  /// Width of view.
  public var width: CGFloat {
    get {
      return self.frame.size.width
    }
    set {
      self.frame.size.width = newValue
    }
  }
  
  /// Height of view.
  public var height: CGFloat {
    get {
      return self.frame.size.height
    }
    set {
      self.frame.size.height = newValue
    }
  }
}

extension UIView {
  
  func superview<T>(of type: T.Type) -> T? {
    return superview as? T ?? superview.flatMap { $0.superview(of: T.self) }
  }
  
}


// MARK: - Methods

public extension UIView {
  
  public typealias Configuration = (UIView) -> Swift.Void
  
  public func config(configurate: Configuration?) {
    configurate?(self)
  }
  
  /// Set some or all corners radiuses of view.
  ///
  /// - Parameters:
  ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
  ///   - radius: radius for selected corners.
  public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let shape = CAShapeLayer()
    shape.path = maskPath.cgPath
    layer.mask = shape
  }
}

extension UIView {
  func searchVisualEffectsSubview() -> UIVisualEffectView? {
    if let visualEffectView = self as? UIVisualEffectView {
      return visualEffectView
    } else {
      for subview in subviews {
        if let found = subview.searchVisualEffectsSubview() {
          return found
        }
      }
    }
    return nil
  }
  
  /// This is the function to get subViews of a view of a particular type
  /// https://stackoverflow.com/a/45297466/5321670
  func subViews<T : UIView>(type : T.Type) -> [T]{
    var all = [T]()
    for view in self.subviews {
      if let aView = view as? T{
        all.append(aView)
      }
    }
    return all
  }
  
  
  /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
  /// https://stackoverflow.com/a/45297466/5321670
  func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
    var all = [T]()
    func getSubview(view: UIView) {
      if let aView = view as? T{
        all.append(aView)
      }
      guard view.subviews.count>0 else { return }
      view.subviews.forEach{ getSubview(view: $0) }
    }
    getSubview(view: self)
    return all
  }
}


extension UIView {
  func dropShadow(scale: Bool = true, height: CGFloat) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.brown.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: 1.5, height: 1)
    layer.shadowRadius = 1
    
    layer.shadowPath = UIBezierPath(rect: CGRect.init(origin: bounds.origin, size: CGSize.init(width: 156, height: height))).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

