//
//  HQUIGestureRecognizer.swift
//  ango
//
//  Created by HaiQuan on 2017/4/11.
//  Copyright © 2017年 HaiQuan. All rights reserved.
//

import UIKit

import UIKit.UIGestureRecognizerSubclass

class HQUIGestureRecognizer: UIGestureRecognizer {

    var  rotation: CGFloat = 0.0
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        
        super.touchesMoved(touches, with: event)
        if (self.state == .possible) {
            self.state = .began
        } else {
            self.state = .changed
        }
        
        // 获取手指触摸view是的任意一个触摸对象
        let touch = (touches as NSSet).anyObject()
        // 获取是手指触摸的view
        let view = self.view
        
        let center = CGPoint.init(x: (view?.bounds.midX)!, y: (view?.bounds.midY)!)
        
        let currentTouchPoint = (touch as AnyObject).location(in: view)
        let previousTouchPoint = (touch as AnyObject).previousLocation(in: view)
        
        // 根据反正切函数计算角度
        let  angleInRadians = atan2f(Float(currentTouchPoint.y) - Float(center.y), Float(currentTouchPoint.x) - Float(center.x)) - atan2f(Float((previousTouchPoint.y)) - Float(center.y), Float((previousTouchPoint.x)) - Float(center.x));
        
        
        // 给属性赋值 记录每次移动的时候偏转的角度 通过角度的累加实现旋转效果
        rotation = CGFloat(angleInRadians)
        

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        if (self.state == .changed) {
            self.state = .ended
        } else {
            self.state = .failed
        }

    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        self.state = .failed
        
    }
}
