//
//  pickerview.swift
//  huobanyun
//
//  Created by AirBook on 2017/6/28.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit

class pickerview: UIView {
    
        let screen_width = UIScreen.main.bounds.size.width
        let screen_height = UIScreen.main.bounds.size.height
        let backGroundView = SpringView() //白色框
        let titleLabel = UILabel() //标题按钮
        var lineview = UIView()
        let tap = UITapGestureRecognizer() //点击手势
        var block:((_ date:String)->())?
        var cancelBtn = UIButton()
        var pickerview = UIPickerView()
        init(title:String,canclebtntitle:String) {
            super.init(frame:CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
            creatalertview()
            titleLabel.text = title
            cancelBtn.setTitle(canclebtntitle, for: .normal)
        }
        func creatalertview(){
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
            //pickerview
            pickerview.frame = CGRect(x: 0, y: 55, width: screen_width, height: 0.4*screen_height-40)
            pickerview.delegate = self
            pickerview.dataSource = self
            pickerview.selectRow(0, inComponent: 0, animated: true)
            pickerview.selectRow(0, inComponent: 1, animated: true)
            backGroundView.addSubview(pickerview)
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
//数据源代理
extension pickerview:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 9
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "3"
    }
}
