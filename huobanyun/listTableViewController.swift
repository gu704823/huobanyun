//
//  listTableViewController.swift
//  huobanyun
//
//  Created by AirBook on 2017/6/17.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit

class listTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupui()
        tableView.separatorStyle = .none
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
    }
    fileprivate lazy var creatbutton:UIButton = {[weak self] in
        let btn = UIButton()
        btn.frame = CGRect(x: screenwidh*0.85, y: screenheight*0.8, width: 0.1*screenwidh, height: 0.1*screenwidh)
        btn.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        btn.addTarget(self, action: #selector(onclick), for: .touchUpInside)
        return btn
        }()
    //按钮点击
    @objc fileprivate func onclick(){
        let vc  = UIStoryboard(name: "completion", bundle: nil).instantiateInitialViewController() as! UITableViewController
            show(vc, sender: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath)
        return cell
    }
}
extension listTableViewController{
    fileprivate func setupui(){
        view.addSubview(creatbutton)
    }
}
