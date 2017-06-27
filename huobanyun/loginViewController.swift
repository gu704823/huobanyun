//
//  loginViewController.swift
//  demo
//
//  Created by swift on 2017/6/25.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit
import LeanCloud
class loginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginin: UIButton!
    @IBOutlet weak var bgview: UIView!
    
    var bggifview:giftview?
    var resultalertview:alertview?
    //左手离脑袋的距离
    var offsetLeftHand:CGFloat = 60
    
    //左手图片,右手图片(遮眼睛的)
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    
    //左手图片,右手图片(圆形的)
    var imgLeftHandGone:UIImageView!
    var imgRightHandGone:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //猫头鹰头部
        let imgLogin =  UIImageView(frame:CGRect(x: mainSize.width/2-211/2, y: 105, width: 211, height: 109))
        imgLogin.image = UIImage(named:"owl-login")
        imgLogin.layer.masksToBounds = true
        self.view.addSubview(imgLogin)
        
        //猫头鹰左手(遮眼睛的)
        let rectLeftHand = CGRect(x: 61 - offsetLeftHand, y: 90, width: 40, height: 65)
        imgLeftHand = UIImageView(frame:rectLeftHand)
        imgLeftHand.image = UIImage(named:"owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        //猫头鹰右手(遮眼睛的)
        let rectRightHand = CGRect(x: imgLogin.frame.size.width / 2 + 60, y: 90, width: 40, height: 65)
        imgRightHand = UIImageView(frame:rectRightHand)
        imgRightHand.image = UIImage(named:"owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        //登录框背景
        bgview.layer.borderColor = UIColor.lightGray.cgColor
        bgview.layer.borderWidth = 1
        bgview.layer.cornerRadius = 10
        bgview.layer.masksToBounds = true
        bgview.backgroundColor = UIColor(white: 1, alpha: 1)
        self.view.insertSubview(bgview, at: 10)
       //gif
        bggifview = giftview(filename: "timg1")
        self.view.insertSubview(bggifview!, at: 1)

        
        //猫头鹰左手(圆形的)
        let rectLeftHandGone = CGRect(x: mainSize.width / 2 - 105,
                                      y: bgview.frame.origin.y-25 , width: 40, height: 40)
        imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgLeftHandGone)
        
        //猫头鹰右手(圆形的)
        let rectRightHandGone = CGRect(x: mainSize.width / 2 + 62,
                                       y: bgview.frame.origin.y-25, width: 40, height: 40)
        imgRightHandGone = UIImageView(frame:rectRightHandGone)
        imgRightHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgRightHandGone)
       //代理
        userid.delegate = self
        password.delegate = self
        //place
        password.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [NSForegroundColorAttributeName:UIColor.groupTableViewBackground])
        userid.attributedPlaceholder = NSAttributedString(string: "手机号/用户名", attributes: [NSForegroundColorAttributeName:UIColor.groupTableViewBackground])
        loginin.addTarget(self, action: #selector(logininaction), for: .touchUpInside)
    }
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        //如果当前是用户名输入
        if textField.isEqual(userid){
      //播放不遮眼动画
            UIView.animate(withDuration: 0.5, animations: { 
                self.imgLeftHand.frame = CGRect(
                    x: self.imgLeftHand.frame.origin.x - self.offsetLeftHand,
                    y: self.imgLeftHand.frame.origin.y + 30,
                    width: self.imgLeftHand.frame.size.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x: self.imgRightHand.frame.origin.x + 48,
                    y: self.imgRightHand.frame.origin.y + 30,
                    width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x: self.imgLeftHandGone.frame.origin.x - 70,
                    y: self.imgLeftHandGone.frame.origin.y, width: 40, height: 40)
                self.imgRightHandGone.frame = CGRect(
                    x: self.imgRightHandGone.frame.origin.x + 30,
                    y: self.imgRightHandGone.frame.origin.y, width: 40, height: 40)
            })
        }
            //如果当前是密码名输入
        else if textField.isEqual(password){
            //播放遮眼动画
            UIView.animate(withDuration: 0.5, animations: {
                self.imgLeftHand.frame = CGRect(
                    x: self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
                    y: self.imgLeftHand.frame.origin.y - 30,
                    width: self.imgLeftHand.frame.size.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x: self.imgRightHand.frame.origin.x - 48,
                    y: self.imgRightHand.frame.origin.y - 30,
                    width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x: self.imgLeftHandGone.frame.origin.x + 70,
                    y: self.imgLeftHandGone.frame.origin.y, width: 0, height: 0)
                self.imgRightHandGone.frame = CGRect(
                    x: self.imgRightHandGone.frame.origin.x - 30,
                    y: self.imgRightHandGone.frame.origin.y, width: 0, height: 0)
            })
        }
    }
      func logininaction(){
        guard let id = userid.text,let ps = password.text else {
            return
        }
        userlogin(userid: id, password: ps)
    }
    func userlogin(userid:String,password:String){
        let username = LCQuery(className: "user")
        username.whereKey("userid", .equalTo(userid))
        let lgpassword = LCQuery(className: "user")
        lgpassword.whereKey("password", .equalTo(password))
        let query = username.and(lgpassword)
        query.getFirst { (result ) in
            switch result {
            case .failure(error: _):
                self.resultalertview = alertview(title: "警告", message: "你输入的账号,或者密码错误,你可以联系管理员获取账号和密码",canclebtntitle: "取消",surebtntitle: "确定", animation: "pop")
                self.resultalertview?.show()
            case .success(object: _):
                //本地保存用户登陆信息
                let userdefaults = UserDefaults.standard
                userdefaults.set(userid, forKey: "name")
                userdefaults.set(password, forKey: "password")
                userdefaults.synchronize()
              
                let sb  = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = sb.instantiateInitialViewController()!
                self.present(vc, animated: true, completion: nil)
               //self.show(vc, sender: nil)
            }
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//    func userregister(){
//        let user = LCObject(className: "User")
//        user.set("id", value: "")
//    }
//    func creat(){
//        //中间表
//        let studenttom = LCObject(className: "Student")
//        studenttom.set("name", value: "Tom")
//
//        let courseLinearAlgebra = LCObject(className: "Course")
//        courseLinearAlgebra.set("name", value: "线性代数")
//
//        let studentCourseMapTom = LCObject(className: "StudentCourseMap")
//
//        //关联
//        studentCourseMapTom.set("student", value: studenttom)
//        studentCourseMapTom.set("course", value: courseLinearAlgebra)
//
//        studentCourseMapTom.set("duration", value: ["2016-02-19","2016-04-21"])
//        studentCourseMapTom.set("platform", value: "IOS")
//
//        studentCourseMapTom.save()
//    }
//    //查询
//    func search(){
//        let courseCalculus = LCObject(className: "Course", objectId: "594f6a931b69e60062c881db")
//        let query = LCQuery(className: "StudentCourseMap")
//        query.whereKey("course", .equalTo(courseCalculus))
//        query.find { (result) in
//            switch result {
//            case .failure(error: let error):
//                print(error)
//            case .success(objects: let success):
//                for studentcourse in success{
//                    let student = studentcourse["student"]?.jsonString
//                    guard  let course = studentcourse["course"]?.jsonValue else {return}
//                    guard   let id = course["objectId"] else {return}
//                    print(id)
//                    let query = LCQuery(className: "Course")
//                    query.get("\(id!)", completion: { (result) in
//                        switch result{
//                        case .failure(error: _):return
//                        case .success(object: let tofo):
//                            print(tofo["name"]?.rawValue)
//                        }
//                    })
//
//
//                    let duration = studentcourse["duration"]?.rawValue
//                    let platform = studentcourse["platform"]?.rawValue
//
//                    //self.resultlabel.text = course
//                   // print(studentcourse)
//                }
//            }
//        }
//    }
//    func  search2(){
//        let query = LCQuery(className: "StudentCourseMap")
//        let studentTom = LCObject(className: "Student", objectId: "594f61498d6d810057026e1d")
//        query.whereKey("student", .equalTo(studentTom))
//        query.find { (result) in
//            switch result{
//            case .failure(error: let failure):
//                print(failure)
//            case .success(objects: let success):
//                for i in success{
//                    let text = i["name"]
//                  //  self.resultlabel.text = text
//                    print(text)
//                }
//            }
//        }
//    }
