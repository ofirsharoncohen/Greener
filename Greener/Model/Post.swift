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
    var lastUpdate: Int64?
    
    init(id:String, userId:String, content:String, pic:String){
        self.id = UUID().uuidString
        self.userId = userId
        self.content = content
        self.pic = pic
    }
    
    init (id:String)
    {
        self.userId = id
        self.id = UUID().uuidString
    }
    
}
