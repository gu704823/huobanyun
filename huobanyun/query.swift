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
}
