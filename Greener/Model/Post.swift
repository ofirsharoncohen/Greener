//
//  Post.swift
//  Greener
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class Post {
    
    var id:String = ""
    var userId:String = ""
    var content:String = ""
    var pic:String = ""
    
    init(id:String, userId:String, content:String, pic:String){
        self.id = id
        self.userId = userId
        self.content = content
        self.pic = pic
    }
    
    init(json:[String:Any]){
        self.id = json["id"] as! String;
        self.userId = json["userId"] as! String;
        self.content = json["content"] as! String;
        self.pic = json["pic"] as! String;
    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["id"] = id
        json["userId"] = userId
        json["content"] = content
        json["pic"] = pic
        return json;
    }
}
