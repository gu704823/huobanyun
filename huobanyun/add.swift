//
//  add.swift
//  huobanyun
//
//  Created by AirBook on 2017/6/18.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit
import LeanCloud
//enum priority{
//    case 高
//    case 中
//    case 低
//}
//enum state{
//    case 未开始
//    case 进行中
//    case 已完成
//}
struct addandquery {
    //添加任务
    static func addtarget(classname:String,person:[String],taskdescription:String,taskname:String,finshtime:Date,priority:String,state:String,creatpeople:String){
        let lcdate = LCDate(finshtime)
        let todo = LCObject(className: classname)
        todo.set("taskdescription", value:taskdescription )
        todo.set("priority", value: priority)
        todo.set("state", value: state)
        todo.set("taskname", value: taskname)
        todo.set("finshtime", value: lcdate)
        todo.set("user", value: creatpeople)
        //人(关联)
        //支行(关联)
        
        
        todo.save()
    }
    //查询任务
    static func querytask(classname:String){
        let query = LCQuery(className: classname)
        query.limit = 20
        query.find { (result) in
            switch result {
            case.success(objects: let objects):
              print(objects)
            case .failure(error: _): break
            }
        }
    }
   //区域与支行
    static func creatarea(areaname:String,zhihangname:String){
        let area = LCObject(className: "area")
        area.set("name", value: areaname)
        
        let renmminlu = LCObject(className: "zhihang")
        renmminlu.set("name", value: zhihangname)
        
        renmminlu.set("dependent", value: area)
        
        renmminlu.save()
        
        
    }
    //查找所有的区域
    static func queryarea(completion:@escaping (_ areaname:[String])->()){
        let query = LCQuery(className: "area")
        query.find { (results) in
            switch results{
            case .failure(error: _):return
            case .success(objects: let objects):
                let areas = objects.map{
                    return $0["name"]?.stringValue
                }
                completion(areas as! [String])
            }
        }
    }
    //根据指定的区域查找id
    static func queryid(name:String,completion:@escaping (_ areaname:String)->()){
        let query = LCQuery(className: "area")
        query.whereKey("name", .equalTo(name))
        query.find { (results) in
            switch results{
            case .failure(error: _):return
            case .success(objects: let objects):
                for object in objects{
                    completion(object["objectId"]?.stringValue ?? "2")
                }
            }
        }
        
    }
    //根据指定的区域id添加支行
    static func addzhihang(name:String){
        queryid(name: name) { (id) in
            let area = LCObject(className: "area", objectId: id)
            let haipeng = LCObject(className: "zhihang")
            haipeng.set("name", value: "海鹏")
            haipeng.set("dependent", value: area)
            haipeng.save()
        }
    }
    //根据指定的区域id查找支行
    static func queryzhihang(name:String,completion:@escaping (_ zhihang:[String])->()){
     queryid(name: name) { (id) in
        let query = LCQuery(className: "zhihang")
        let area = LCObject(className: "area", objectId: id)
        query.whereKey("dependent", .equalTo(area))
        query.find({ (result) in
            switch result{
            case .failure(error: _):return
            case .success(objects: let objects):
                let zhihzang = objects.map{
                    return $0["name"]?.stringValue
                }
            completion(zhihzang as! [String])
            }
        })
        }
        
        
    }
  
    
    
    
    
}
