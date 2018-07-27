//
//  ZSNavigationBar.swift
//  ZSNavigationBar
//
//  Created by zakariyyasv on 2018/7/26.
//  Copyright © 2018年 Lingyue. All rights reserved.
//

import Foundation
import UIKit

public extension UINavigationBar {
  
  private struct AssociatedKeys {
    static var overlayKey = "overlayKey"
    static var kvoObserverKey = "kvoObserver"
    static var deinitExecutorKey = "deinitExecutor"
  }
  
  // MARK: Runtime Properties
  private var overlay: UIView? {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.overlayKey) as? UIView
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKeys.overlayKey, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
  }
  
  private var observer: NSKeyValueObservation! {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.kvoObserverKey) as? NSKeyValueObservation
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKeys.kvoObserverKey, newValue as NSKeyValueObservation?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
  }

  private var deinitExecutor: ZSDeinitExecutor! {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.deinitExecutorKey) as? ZSDeinitExecutor
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKeys.deinitExecutorKey, newValue as ZSDeinitExecutor?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
  }
  
  // MARK: Public Methods
  func setCustomBackgroundColor(_ backgroundColor: UIColor) {

    guard let barBackgroundCls = NSClassFromString("_UIBarBackground") else {
      return
    }
    
    if overlay == nil {
      
      DispatchQueue.main.async {
        
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        self.overlay = UIView()
        self.overlay?.isUserInteractionEnabled = false
        self.subviews.first?.insertSubview(self.overlay!, at: 0)
      }
      
    }
    
    if self.observer == nil {

      if let barBackgroundView = subviews.first(where: {
        return $0.classForCoder == barBackgroundCls
      }) {
        
        self.observer = barBackgroundView.observe(\.frame, options: [.initial, .new]) { [unowned self] (_, change) in
          
          if let frame = change.newValue {

            DispatchQueue.main.async {
              self.overlay?.frame = CGRect(origin: CGPoint.zero, size: frame.size)
            }

          }
        }
        
        self.deinitExecutor = ZSDeinitExecutor(executorClosure: { [unowned self] in
          self.observer?.invalidate()
        })
        
      } else {
        return
      }
    }
    
    DispatchQueue.main.async {
      self.overlay?.backgroundColor = backgroundColor
    }

  }
  
  func setCustomTranslationY(translationY: CGFloat) {
    transform = CGAffineTransform(translationX: 0, y: translationY)
  }
  
  func reset() {

    DispatchQueue.main.async {
      self.setBackgroundImage(nil, for: UIBarMetrics.default)
      self.overlay?.removeFromSuperview()
      self.overlay = nil
    }
    
  }

}
