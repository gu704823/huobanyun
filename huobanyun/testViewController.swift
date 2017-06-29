//
//  testViewController.swift
//  huobanyun
//
//  Created by AirBook on 2017/6/29.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit

class testViewController: UIViewController {
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var showlabel: UILabel!

    var areaarry:[Any] = []{
        didSet{
            print(areaarry)
        }
    }

    var areanames:[String]?{
        didSet{
            print(areanames)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addandquery.queryarea { (areas) in
            self.areanames = areas
            var zhihang = ["":""]
            for i in areas{
                addandquery.queryzhihang(name: i, completion: { (object) in
                    zhihang = ["\(i)":"\(object)"]
                    
                })
                
                
            }
            
        }
        //addandquery.creatarea(areaname: "总行", zhihangname: "科技部")
    

    }
    
}
