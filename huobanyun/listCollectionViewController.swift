//
//  listCollectionViewController.swift
//  huobanyun
//
//  Created by AirBook on 2017/6/17.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit
import LeanCloud
enum state:String {
    case 未开始 = "未开始"
    case 进行中 = "进行中"
    case 已完成 = "已完成"
}
enum priority:String {
    case 低 = "低"
    case 中 = "中"
    case 高 = "高"
}

class listCollectionViewController: UICollectionViewController {
    //拖控件
    @IBAction func addzhihang(_ sender: UIBarButtonItem) {
        leftbtnonclick()
    }
    
//定义数据
    var zhihang:[LCObject] = []
    var refreshcontrol = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        refershdata()
        
//        let date = Date()
//        let userdefaults = UserDefaults.standard
//        let name = userdefaults.object(forKey: "name")!
        
      //  addandquery.addtarget(classname: "addtarget", person: ["swift","jaso"], taskdescription: "打印机坏了", taskname: "壮志", finshtime: date, priority: "高", state: "已完成", creatpeople: name as! String)
        
        //query.onsearch(name: "addtarget", classname: "壮志")
        let query = LCQuery(className: "zhihang")
        query.find { (result) in
            switch result {
            case .success(objects: let objects):
                for object in objects{
                    print(object["area"]?.stringValue)
                }
            case .failure(error: let error):
                print(error)
            }
        }
        
        
        
        
        
       
        
        
        
        refreshcontrol.addTarget(self, action: #selector(refershdata), for: .valueChanged)
        refreshcontrol.attributedTitle = NSAttributedString(string: "下拉刷新支行")
        collectionView?.addSubview(refreshcontrol)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
    }
    //刷新数据
    @objc fileprivate func refershdata(){
        refreshcontrol.beginRefreshing()
        DispatchQueue.global().async { 
            query.getdata(classname:"zhihang", completion: { (results) in
                self.zhihang = results
                self.collectionView?.reloadData()
            })
            DispatchQueue.main.async {
                self.refreshcontrol.endRefreshing()
            }
        }
    }
}
//MARK:-点击事件汇合
extension listCollectionViewController{
    //导航左边的按钮点击事件
    fileprivate func leftbtnonclick(){
       let alertcontroller = UIAlertController(title: "添加支行", message: "请添加支行名称", preferredStyle: .alert)
        alertcontroller.addTextField { (textfiled:UITextField) in
            textfiled.placeholder = "支行名称"
        let cancleanction = UIAlertAction(title: "取消", style: .cancel
            , handler: nil)
        let okaction = UIAlertAction(title: "确定", style: .default) { (_) in
           let name = (alertcontroller.textFields?.first?.text)!
            if (name == ""){
                let alertcontroller = UIAlertController(title: "警告", message: "请输入正确的支行名称", preferredStyle: .alert)
                let okaction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
                alertcontroller.addAction(okaction)
                self.present(alertcontroller, animated: true, completion: nil)
                return
            }else{}
            
            self.adddata(classname: "zhihang", value: name)
            //self.collectionView?.reloadData()
        }
        alertcontroller.addAction(cancleanction)
        alertcontroller.addAction(okaction)
        self.present(alertcontroller, animated: true, completion: nil)
      }
    }
     func adddata(classname:String,value:String){
    let query = LCQuery(className: classname)
    query.whereKey("name",.equalTo("\(value)"))
        query.getFirst { (results) in
            switch results {
            case .failure(error: _):
                let todoFolder = LCObject(className: classname)
                todoFolder.set("name", value: "\(value)")
                todoFolder.save({ (result) in
                    switch results{
                    case .failure(error: _): break
                    case .success(object: _): break
                    }
                })
            case .success(object: _):
                let alertcontroller = UIAlertController(title: "警告", message: "你已经添加了这个支行", preferredStyle: .alert)
                let okaction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
                alertcontroller.addAction(okaction)
                self.present(alertcontroller, animated: true, completion: nil)
            }
        }
  }
}

//MARK:-collectionview
extension listCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return zhihang.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listcollectcell", for: indexPath) as! listCollectionViewCell
        cell.name.text = zhihang[indexPath.row]["name"]?.stringValue
        cell.badgeCenterOffset = CGPoint(x: -15, y: 10)
        cell.showBadge(with: .number, value: 2, animationType: .shake)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
