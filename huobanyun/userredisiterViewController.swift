//
//  userredisiterViewController.swift
//  demo
//
//  Created by swift on 2017/6/25.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit
import LeanCloud
class userredisiterViewController: UIViewController {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var regisiterbtn: UIButton!
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
//
    var resultalert:alertview?
    override func viewDidLoad() {
        super.viewDidLoad()
        password.attributedPlaceholder = NSAttributedString(string: "请输入注册密码", attributes: [NSForegroundColorAttributeName:UIColor.white])
        userid.attributedPlaceholder = NSAttributedString(string: "注册手机号/用户名", attributes: [NSForegroundColorAttributeName:UIColor.white])
        regisiterbtn.addTarget(self, action: #selector(regisiter), for: .touchUpInside)
        
        
    }
    @objc fileprivate func regisiter(){
        guard let ps = password.text,let id = userid.text else {
            return
        }
        if (ps.characters.count>0)&&(id.characters.count>0){
            query(userid: id, password: ps)
        }else{
            self.resultalert = alertview(title: "警告", message: "你填写的注册/密码项为空,请正确注册",canclebtntitle: "取消",surebtntitle: "确定", animation: "pop")
            self.resultalert?.show()
        }
    }
    func query(userid:String,password:String){
        let query = LCQuery(className: "user")
        query.whereKey("userid", .equalTo(userid))
        query.getFirst { (result) in
            switch result {
            case .failure(error: _):
                self.userregisiter(userid: userid, password: password)
            case .success(object: _):
                self.resultalert = alertview(title: "警告", message: "该用户名已经被注册,请更换用户名注册",canclebtntitle: "取消",surebtntitle: "确定", animation: "pop")
                self.resultalert?.show()
            }
        }
    }
    func userregisiter(userid:String,password:String){
        let user = LCObject(className: "user")
        user.set("userid", value: userid)
        user.set("password", value: password)
        user.save { (result) in
            switch result{
            case .failure(error: _):return
            case .success:
                self.resultalert = alertview(title: "恭喜", message: "你已经成功注册,请进行登陆吧",canclebtntitle: "取消",surebtntitle: "确定", animation: "pop")
                self.resultalert?.show()
                self.dismiss(animated: true, completion: nil)
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
