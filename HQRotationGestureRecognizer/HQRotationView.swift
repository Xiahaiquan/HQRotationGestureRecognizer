//
//  RotationView.swift
//  ango
//
//  Created by HaiQuan on 2017/3/19.
//  Copyright © 2017年 HaiQuan. All rights reserved.
//

import UIKit

protocol Delegate {
    
    func btnDidSelected(_ tag : Int)
}

class HQRotationView: UIView {
    
    
    var delegate : Delegate?
    
    typealias btnDidClicked = (_ tag: Int) -> ()
    
    var clicked: btnDidClicked?
    
   
    
//    typealias selectCloseBage = (_ selet: Int) -> Void
//    var selected = selectCloseBage?()
    //Cannot invoke initalizer for type "Bage" with no arguments
    var  _btnArray = [UIButton]()
    
    var  rotationAngleInRadians: CGFloat = 0
    var  radians: CGFloat = 0
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.width / 2 ;
        self.width = self.frame.size.width;
        
        
        self.addGestureRecognizer(HQUIGestureRecognizer.init(target: self, action: #selector(changeMove)))
        
        
        self.isUserInteractionEnabled = true
        
        //        self.backgroundColor = .yellow
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Btn(BtnWidth: CGFloat, sizeWith: CGFloat, mask: Bool, radius:  CGFloat, image: [String],titileArray: [String]) {
        let corner = (-M_PI * 2.0 / Double(titileArray.count ))
        // 半径为 （转盘半径➖按钮半径）的一半
        let  r = (self.width  - BtnWidth) / 2 ;
        let  x = self.width  / 2 ;
        let  y = self.width  / 2 ;
        
        
        for i in 0 ..< titileArray.count {
            
            let  btn = UIButton.init()
            btn.frame = CGRect.init(x: 0, y: 0, width: BtnWidth, height: BtnWidth)
            btn.layer.masksToBounds = mask;
            btn.layer.cornerRadius = radius;
            
            let x1 = x + r * CGFloat(cos(corner * Double(i)))
            let y1 = y + r * CGFloat(sin(corner * Double(i)))
            btn.center =  CGPoint.init(x: x1, y: y1)
            
            
            
            btn.tag = i;
            
            btn.setTitle(titileArray[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            btn.titleLabel?.backgroundColor = .blue
            btn.setImage(UIImage.init(named: image[i]), for: .normal)
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView!.intrinsicContentSize.width , -(btn.imageView!.intrinsicContentSize.height+2.0/2.0), 0)
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(-(btn.titleLabel!.intrinsicContentSize.height+2.0/2.0), 0, 0, -btn.titleLabel!.intrinsicContentSize.width)
            
            
            
            
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            

            
            self.addSubview(btn)
            _btnArray.append(btn)
            
            
            
        }
    }
    
    
    func btnClick(_ sender: UIButton) {
        
        print("Item点击",sender.tag)
        
        if clicked != nil {
            
            clicked!(sender.tag)
        }
    }
    
    func selectBtn() {
        

        let f = self.rotationAngleInRadians*CGFloat(180/M_PI);
        
        let  i = fabs(f) / 90;
        
        let s = i.truncatingRemainder(dividingBy: 4)
        
        delegate?.btnDidSelected(Int(s))
        
        
    }
    
}

extension HQRotationView {
    
    func changeMove(_ retation:HQUIGestureRecognizer ) {
        
        
        switch (retation.state) {
            
            
            
        case .changed:
            
            self.rotationAngleInRadians += retation.rotation
            
            let r = self.rotationAngleInRadians + retation.rotation
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.transform = CGAffineTransform(rotationAngle: r)
                
                for btn in self._btnArray {
                    
                    btn.transform = CGAffineTransform(rotationAngle: -r)
                }
            })
            
            
            radians = r
            
            
            
        case .ended:
            
            let  num = Int(self.rotationAngleInRadians / CGFloat(M_PI/2))
            let  last = Int(self.rotationAngleInRadians * CGFloat(180/M_PI)) % 60
            
            //            int last = ((int)(self.rotationAngleInRadians*(180/M_PI)))%(60);
            
            
            //            print(last)
            if (abs(last)>=30) {
                
                var r: Double = 0
                UIView.animate(withDuration: 0.25, animations: {
                    
                    r = (M_PI / 2) * (Double(num) + Double(1))
                    
                    self.transform = CGAffineTransform(rotationAngle: CGFloat(r))
                    
                    for btn in self._btnArray {
                        btn.transform = CGAffineTransform(rotationAngle: CGFloat(-r))
                    }
                })
                radians = CGFloat(r)
                self.rotationAngleInRadians = CGFloat(r)
                
                
            }
            else{
                var n: Double = 0
                UIView.animate(withDuration: 0.25, animations: {
                    
                    n = (M_PI / 2) * Double(num)
                    
                    self.transform = CGAffineTransform(rotationAngle: CGFloat(n))
                    
                    
                    for btn in self._btnArray {
                        btn.transform = CGAffineTransform(rotationAngle: CGFloat(-n));
                    }
                })
                
                radians = CGFloat(n)
                self.rotationAngleInRadians = CGFloat(n)
                
                
            }
            
            self.selectBtn()
            
        default:
            break
        }
        
        
    }
    
}
