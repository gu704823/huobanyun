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
}
