//
//  BSDropper.swift
//  Sidekick
//
//  Created by Seoksoon Jang on 2019. 2. 10..
//  Copyright © 2019년 @boraseoksoon. All rights reserved.
//

import UIKit

public class BSDropper: UIView {
  // MARK: - IBOutlet, IBActions -
  public var closureBtTopicSelect: ((_ topicName: String) -> Void)?
  @IBOutlet var btTopicSelect: UIButton!
  @IBAction func actionBtTopicSelect(_ sender: Any) {
    if let sender = sender as? UIButton {
      if let text = sender.titleLabel?.text {
        closureBtTopicSelect?(text)
      } else {
        //
      }
    } else {
      //
    }
  }
  
  public var closureBtAlarm: (() -> Void)?
  @IBOutlet var btAlarm: UIButton!
  @IBAction func actionBtAlarm(_ sender: Any) {
    closureBtAlarm?()
  }
  
  public var closureBtMyPage: (() -> Void)?
  @IBOutlet var btMyPage: UIButton!
  @IBAction func actionBtMyPage(_ sender: Any) {
    closureBtMyPage?()
  }
  
  @IBOutlet var pnlSearchTextFieldViewBlock: UIView! {
    didSet {
      pnlSearchTextFieldViewBlock.dropShadow(shadowColor: UIColor.bsDropperGray.cgColor, strength: 1.5)
    }
  }
  
  @IBOutlet public var tfSearch: UITextField! {
    didSet {
      let imageView = UIImageView(image: #imageLiteral(resourceName: "iconSearch"))
      let leftView = UIView(frame: CGRect(x:0, y:0, width: imageView.frame.size.width + 20, height: imageView.frame.size.height))
      leftView.addSubview(imageView)
      
      var frame = imageView.frame
      frame.origin.x = frame.origin.x + 10.0
      imageView.frame = frame
      
      tfSearch.leftView = leftView
      tfSearch.leftViewMode = .always
      tfSearch.autocorrectionType = .no
    }
  }
  
  public var closureBtFilterPost: (() -> Void)?
  @IBOutlet var btFilterPost: UIButton!
  @IBAction func actionBtFilterPost(_ sender: Any) {
    closureBtFilterPost?()
  }
  // MARK: - Instance Variables -
  private var startOffsetY: CGFloat = 0.0
  private var lastContentOffset: CGFloat = 0.0
  
  public var adjustedContentInset: UIEdgeInsets {
    return UIEdgeInsets(top: self.frame.size.height - 20.0, left: 0, bottom: 0, right: 0)
  }
  
  // MARK: - Constants -
  public static let XIB_NAME_CONSTANT = "BSDropper"
  
  public static let HEIGHT: CGFloat = 168
  public static let WIDTH: CGFloat = UIScreen.main.bounds.width
  
  // MARK: - View LifeCycle Methods -
  public override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    self.dropShadow(strength: 0.5)
    self.addBottomBorderWithColor(color: .bsDropperDisable, width: 0.5)
  }
}

// MARK: - Own Methods -
extension BSDropper {
  public func show(completion: @escaping () -> Void) -> Void {
    UIView.animate(withDuration: 0.1, animations: {
      self.frame.origin.y = 0
      self.layoutIfNeeded()
    }, completion: { _ in
      completion()
    })
  }

  public func check(offsetY: CGFloat) -> Void {
    self.lastContentOffset = 0.0
    self.startOffsetY = offsetY
  }
  
  public func observe(_ scrollView: UIScrollView) -> Void {
    let totalOffSetY = self.startOffsetY - scrollView.contentOffset.y
    let differenceOffsetY = totalOffSetY - lastContentOffset
    
    if self.lastContentOffset != 0.0 {
      if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0) {
        // Going up
        if differenceOffsetY > 0.0 {
          guard self.frame.origin.y <= 0 else {
            lastContentOffset = totalOffSetY
            self.frame.origin.y = 0
            return
          }
          
          if self.frame.origin.y + differenceOffsetY > 0 {
            self.frame.origin.y = 0
          } else {
            self.frame.origin.y += differenceOffsetY
          }
        }
      } else {
        // Going down
        if differenceOffsetY < 0.0 {
          guard self.frame.origin.y >= 0 - self.frame.size.height else {
            lastContentOffset = totalOffSetY
            self.frame.origin.y = 0 - self.frame.size.height
            return
          }
          
          if self.frame.origin.y + differenceOffsetY < 0 - self.frame.size.height {
            self.frame.origin.y = 0 - self.frame.size.height
          } else {
            self.frame.origin.y += differenceOffsetY
          }
        }
      }
    }
    
    lastContentOffset = totalOffSetY
  }
}

