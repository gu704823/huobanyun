//
//  alertsheet.swift
//  alertview
//
//  Created by swift on 2017/6/19.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit
class alertsheet: UIView {
//初始化
    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    var backGroundView = SpringView()
    var cancelBtn = UIButton()
    let tap = UITapGestureRecognizer()
    let titleLabel = UILabel()
    let lineview = UIView()
    var count = 0
    var sepwidth:CGFloat = 0
    var block:((_ index:Int)->())?
    
//init
    init(title:String,canclebtntitle:String,buttontitles:[String],buttonimages:[String]){
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        if  buttontitles.count == 0{
            return
        }
        creatview()
        for i in 0...buttontitles.count-1{
            additem(title: buttontitles[i], withimage: UIImage(named: buttonimages[i])!)
        }
        
        self.cancelBtn.setTitle(canclebtntitle, for: .normal)
        self.titleLabel.text = title
        
    }
    fileprivate func creatview(){
        //自定义actionsheet
        self.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        //添加手势
        tap.addTarget(self, action: #selector(self.dismiss))
        self.addGestureRecognizer(tap)
        //白底
        backGroundView.frame = CGRect(x: 0, y: screen_height/2, width: screen_width , height: 0.4*screen_height)
        backGroundView.backgroundColor = UIColor.white
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        backGroundView.layer.cornerRadius = 9
        backGroundView.clipsToBounds = true
       // spring动画
        backGroundView.animation = "morph"
        backGroundView.curve = "Spring"
        backGroundView.duration = 1.4
        backGroundView.damping = 0.7
        backGroundView.velocity = 0.7
        backGroundView.force = 1.0
        backGroundView.animate()
        self.addSubview(backGroundView)
        let width = backGroundView.frame.size.width
        //标题
        titleLabel.frame = CGRect(x: 10, y: 15, width: 0.5*width, height: 25)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textAlignment = .left
        backGroundView.addSubview(titleLabel)
        //取消按钮
        let btnWith = (width - 30) / 4
        cancelBtn.frame = CGRect(x: width-btnWith-10, y: 10, width: btnWith, height: 30)
        cancelBtn.backgroundColor = UIColor.gray
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.layer.cornerRadius = 3
        cancelBtn.clipsToBounds = true
        cancelBtn.tag = 1
        cancelBtn.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)
        backGroundView.addSubview(cancelBtn)
        //细线
        lineview.frame = CGRect(x: 0, y: 50, width: width, height: 1)
        lineview.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        backGroundView.addSubview(lineview)
    }
//创建分享的按钮
    
  fileprivate  func additem(title:String,withimage:UIImage){
        count+=1
        sepwidth = 20 + ((UIScreen.main.bounds.width - 280)/3 + 60)*(CGFloat(count - 1))
        
        let sharebtn = JASharebtn()
        sharebtn.frame = CGRect(x: 0+sepwidth, y: 60, width: 80, height: 80)
        sharebtn.iconimageview.image = withimage
        sharebtn.namelabel.text = title
       sharebtn.addTarget(self, action: #selector(self.btnclick(_:)), for: .touchUpInside)
        sharebtn.tag = 1000+count
        if count>4{
            sepwidth = 20 + ((UIScreen.main.bounds.width - 280)/3 + 60)*(CGFloat(count - 5))
            sharebtn.frame = CGRect(x: 0+sepwidth, y: 140, width: 80, height: 80)
        }
        backGroundView.addSubview(sharebtn)
    }
     func btnclick(_ sender:UIButton){
        block!(sender.tag - 1001)
        dismiss()
    }
    func show() {
       // let wind = UIApplication.shared.keyWindow
        //wind?.addSubview(self)
        UIApplication.shared.windows[0].addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: 0.5) {
            let bcframex = (self.backGroundView.frame.size.width)*CGFloat(1)
            let bcframey = (self.backGroundView.frame.size.height)*CGFloat(1)
            self.backGroundView.frame = CGRect(x: (self.screen_width-bcframex)*0.5, y: self.screen_height -  self.backGroundView.frame.size.height, width: bcframex , height: bcframey)
            self.alpha = 1
        }
    }
    func dismiss(){
        UIView.animate(withDuration: 0.25, animations: {
            self.backGroundView.alpha = 0
            self.alpha = 0
        }) { (finsh) in
            if finsh {
                self.removeFromSuperview()
            }
        }
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
class JASharebtn:UIButton{
    //定义属性
    var iconimageview:UIImageView!
    var namelabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconimageview = UIImageView()
        iconimageview.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        iconimageview.layer.cornerRadius = 5
        self.addSubview(iconimageview)
        
        namelabel = UILabel()
        namelabel.frame = CGRect(x: 0, y: 55, width: 60, height: 20)
        namelabel.textAlignment = .center
        namelabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(namelabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
