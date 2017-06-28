//
//  zhihang.swift
//  huobanyun
//
//  Created by AirBook on 2017/6/18.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit
import LeanCloud


struct query {
    //未做筛选的查找
    static func getdata(classname:String,completion:@escaping ([LCObject])->()){
        let query = LCQuery(className: classname)
    
        query.find { (result) in
            switch result {
            case .success(objects: let objects):
                    completion(objects)
            case .failure(error: let error):
                print(error)
            }
        }
    }
    //筛选查找
    //根据支行名字查找对应的任务
    static func onsearch(name:String,classname:String){
        let query = LCQuery(className: classname)
        query.whereKey("taskname", .equalTo(name))
        query.find { (result) in
            switch result{
            case .failure(error: _):return
            case .success(objects: let objects):
                for object in objects{
                    print(object.jsonString)
                }
            }
        }
    }
    //找出所有的支行
    static func onsearchzhihang(name:String,classname:String){
        let query = LCQuery(className: classname)
        query.whereKey("taskname", .equalTo(name))
        query.find { (result) in
            switch result{
            case .failure(error: _):return
            case .success(objects: let objects):
                for object in objects{
                    print(object.jsonString)
                }
            }
        }
    }

    
}
