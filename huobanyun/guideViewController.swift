//
//  guideViewController.swift
//  huobanyun
//
//  Created by AirBook on 2017/6/26.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit

class guideViewController: UIViewController {
    //定义
    var pagecontrol = UIPageControl()
    var startbtn = UIButton()
    fileprivate var scrollview:UIScrollView!
    fileprivate var numberofpages = 4
    fileprivate let frame = UIScreen.main.bounds
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scrollview = UIScrollView(frame: frame)
        scrollview.isPagingEnabled = true
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.scrollsToTop = false
        scrollview.bounces = false
        scrollview.contentOffset = CGPoint.zero
        scrollview.contentSize = CGSize(width: frame.size.width*CGFloat(numberofpages), height: frame.size.height)
        scrollview.delegate = self
        for index in 0..<numberofpages{
            let imageview = UIImageView(image: UIImage(named: "guideimage\(index+1)"))
            imageview.frame = CGRect(x: frame.size.width*CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollview.addSubview(imageview)
        }
        self.view.insertSubview(scrollview, at: 0)
        //开始按钮
        let btnW = 0.25*frame.size.width
        let btnx = frame.size.width/2 - btnW/2
        let btny = 0.8*frame.size.height
        let btnH = btnW*0.4
        startbtn.frame = CGRect(x: btnx, y:frame.size.height, width: btnW, height: btnH)
        startbtn.setTitle("开始体验", for: .normal)
        startbtn.backgroundColor = UIColor.gray
        startbtn.setTitleColor(UIColor.purple, for: .highlighted)
        startbtn.layer.cornerRadius = 10
        startbtn.layer.masksToBounds = true
        startbtn.alpha = 0
        startbtn.addTarget(self, action: #selector(btnclick), for: .touchUpInside)
        self.view.addSubview(startbtn)
        
        pagecontrol.frame = CGRect(x: btnx, y: btny*1.18, width: btnW, height: btnH)
        pagecontrol.numberOfPages = numberofpages
        pagecontrol.pageIndicatorTintColor = UIColor.black
        pagecontrol.currentPageIndicatorTintColor = UIColor.red
        
        self.view.addSubview(pagecontrol)
    }
    @objc fileprivate func btnclick(){
        let vc = UIStoryboard(name: "loginanderegisiter", bundle: Bundle.main).instantiateInitialViewController()!
        show(vc, sender: nil)
    }
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
extension guideViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let a = Int(offset.x/view.bounds.width)
        pagecontrol.currentPage = a
       // print(a,offset.x,view.bounds.width)
        if a == numberofpages - 1{
            UIView.animate(withDuration: 0.5, animations: {
                self.startbtn.frame.origin.y = (self.frame.height)*0.8
                self.startbtn.alpha = 1
            })
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                self.startbtn.frame.origin.y = self.frame.height
                self.startbtn.alpha = 0
                
            })
        }
    }
}
