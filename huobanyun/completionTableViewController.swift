//
//  completionTableViewController.swift
//  huobanyun
//
//  Created by AirBook on 2017/6/19.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit

class completionTableViewController: UITableViewController {
//拖
    @IBOutlet weak var taskname: UITextField!
    @IBAction func testbtn(_ sender:UIButton) {
    }
    @IBOutlet weak var taskdescriptionname: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var priority: UILabel!
    @IBOutlet weak var statelabel: UILabel!
//定义
var stateview:alertview?
var sheetview:alertsheet?
var finshview:finshtime?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupui()
        //反向传值
//        let vc = taskdescriptionViewController()
//        vc.taskblock = {(taskde) in
//                self.taskdescriptionname.text = taskde
//        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            sheetview = alertsheet(title: "状态", canclebtntitle: "完成", buttontitles: ["未开始","进行中","已完成"], buttonimages: ["sns_icon_1","sns_icon_22","sns_icon_24"])
            sheetview?.show()
            sheetview?.block = {(index) in
                switch index {
                case 0:
                    self.statelabel.text = "未开始"
                    self.statelabel.backgroundColor = UIColor.green
                case 1:
                    self.statelabel.text = "进行中"
                    self.statelabel.backgroundColor = UIColor.red
                case 2:
                    self.statelabel.text = "已完成"
                    self.statelabel.backgroundColor = UIColor.orange
                default:
                    return
                }
            }
        case 4:
            finshview = finshtime(title: "请选择时间", canclebtntitle: "完成")
            finshview?.show()
            finshview?.block = {(date)in
                self.datelabel.text = date
            }
        case 5:
            sheetview = alertsheet(title: "优先级", canclebtntitle: "完成", buttontitles: ["低","中","高"], buttonimages: ["sns_icon_1","sns_icon_22","sns_icon_24"])
            sheetview?.show()
            sheetview?.block = {(index) in
                switch index {
                case 0:
                    self.priority.text = "低"
                    self.priority.backgroundColor = UIColor.green
                case 1:
                    self.priority.text = "中"
                    self.priority.backgroundColor = UIColor.red
                case 2:
                    self.priority.text = "高"
                    self.priority.backgroundColor = UIColor.orange
                default:
                    return
                }
            }
        default:
            return
        }
    }
}

extension completionTableViewController{
    //正向传值
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowChecklist"{
//           let vc  = segue.destination as! taskdescriptionViewController
//            vc.taskdescriptionlabel = taskdescriptionname.text
//        }
//    }
}
    
//ui
extension completionTableViewController{
    fileprivate func setupui(){
        statelabel.layer.cornerRadius = 5
        statelabel.layer.masksToBounds = true
        priority.layer.cornerRadius = 5
        priority.layer.masksToBounds = true
        //完成时间
        let currentdate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        datelabel.text = formatter.string(from: currentdate)
        datelabel.layer.cornerRadius = 5
        datelabel.layer.masksToBounds = true
        //导航
        self.title = "创建"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(back))
    }
}
//按钮点击
extension completionTableViewController{
    @objc fileprivate func back(){
        stateview = alertview(title: "警告", message: "你输入的内容未保存,是否放弃本次编辑操作?", canclebtntitle: "取消", surebtntitle: "放弃", animation: "pop")
        stateview?.show()
        stateview?.block = { (index) in
            if index == 2{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
