//
//  taskdescriptionViewController.swift
//  huobanyun
//
//  Created by swift on 2017/6/24.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit

class taskdescriptionViewController: UIViewController {

    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var taskdescription: UITextView!
    var taskblock:((_ taskde:String)->())?
    var taskdescriptionlabel:String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
  
        

    }
}
