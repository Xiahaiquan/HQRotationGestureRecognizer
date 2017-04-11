//
//  ViewController.swift
//  HQRotationGestureRecognizer
//
//  Created by HaiQuan on 2017/4/11.
//  Copyright © 2017年 HaiQuan. All rights reserved.
//

import UIKit


let WIDTH_SCREEN = UIScreen.main.bounds.width


let HEIGHT_SCREEN = UIScreen.main.bounds.height

let rotBtnsWidth: CGFloat =  80

class ViewController: UIViewController {

    fileprivate var romate: HQRotationView = {
        
        let rotatePlateWidth = WIDTH_SCREEN / ( 1.4)
        let romate = HQRotationView(frame:CGRect(x: 0, y: 0, width: rotatePlateWidth, height: rotatePlateWidth))
        
        let imageArray = ["ango_icon_xuanzhong_adas setting_100pc","ango_icon_xuanzhong_me_100px","ango_icon_xuanzhong_money_100px","ango_icon_xuanzhong_setting_icon_100px"]
        let titleArray = ["HomeMe","HomeSet","ADAS","HomeFortune"]
        romate.Btn(BtnWidth: rotBtnsWidth, sizeWith: rotBtnsWidth, mask: true, radius: rotBtnsWidth/2, image: imageArray, titileArray: titleArray)
        
        
        return romate
        
        
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRomateView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addRomateView() {
        view.addSubview(romate)
        romate.centerY = view.centerY
        romate.centerX = view.centerX.multiplied(by: 1.5)
        
        
        romate.delegate = self
        
        
//        romate.jump = { (num) in
//            
//            self.selectedCategoryEndWithIndex(num)
//        }
//        romate.selected = {[unowned self](select) in
//            
//            print(select)
//                   }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: MyDelegate {
    func didAcceptSomethiong(_ someoneName: Int) {
        print(someoneName)
    }
}

