//
//  giftview.swift
//  alertview
//
//  Created by AirBook on 2017/6/27.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit
import WebKit
//动态图片
class giftview: UIView {
     //定义
    let Screen_width = UIScreen.main.bounds.size.width
    let Screen_height = UIScreen.main.bounds.size.height
    var webbgview = WKWebView()
    init(filename:String){
        super.init(frame: CGRect(x: 0, y: Screen_height/1.6+20, width: Screen_width, height: Screen_height))
        creatbgview(filename: filename)
    }
    fileprivate func creatbgview(filename:String){
        let filepatch = Bundle.main.path(forResource: filename, ofType: "gif")
        let gif = NSData(contentsOfFile: filepatch!)! as Data
        webbgview = WKWebView(frame: CGRect(x: 0, y: 0, width: Screen_width, height: Screen_height))
        let url = NSURL() as URL
        webbgview.load(gif, mimeType: "image/gif", characterEncodingName: String(), baseURL: url)
        webbgview.isUserInteractionEnabled = false
        addSubview(webbgview)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
