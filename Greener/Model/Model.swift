//
//  Model.swift
//  Greener
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class Model{
    static let instance = Model()
    
    func getPosts()->[Post]?{
       let posts = [Post(id:"1234" , userId: "user1", content:"content", pic: "picURL"),Post(id:"34" , userId: "user2", content:"content2", pic: "pic2URL")]
    return posts
    }
}
