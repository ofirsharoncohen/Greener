//
//  Post+Firebase.swift
//  Greener
//
//  Created by Studio on 10/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import Firebase

extension Post{
    convenience init(json:[String:Any]){
        let id = json["id"] as! String;
        self.init(id:id)

        content = json["content"] as! String;
        pic = json["picture"] as! String;
        userId = json["userId"] as! String;
        let ts = json["lastUpdate"] as! Timestamp
        lastUpdate = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = id
        json["content"] = content
        json["picture"] = pic
        json["userId"] = userId
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
