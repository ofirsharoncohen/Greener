//
//  Model.swift
//  Greener
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Model {
    static let instance = Model()
    
    var modelFirebase:ModelFirebase = ModelFirebase()
    
    private init(){
    }
    
    func add(post:Post){
        modelFirebase.add(post: post);
    }
    
    func remove(post:Post, callback: @escaping (Error?)->Void){
        modelFirebase.remove(post: post){ err in
            callback(err);
        }
    }
    
    func getAllPosts(callback:@escaping ([Post]?)->Void){
        //get the local last update date
        let lud = Post.getLastUpdateDate();
        // delete the posts table
        Post.ClearTable(){() in
            //
            //get the cloud updates since the local update date
            self.modelFirebase.getAllPosts(since:lud) { (data) in
                //insert update to the local db
                var lud:Int64 = 0;
                if(data != nil){
                    for post in data!{
                        post.addToDb()
                        if post.lastUpdate! > lud {lud = post.lastUpdate!}
                    }
                }
                //update the students local last update date
                Post.setLastUpdate(lastUpdated: lud)
                // get the complete student list
                let finalData = Post.getAllPostsFromDb()
                callback(finalData);
                //
            };
        }
    }
    func getMyPosts(userId:String, callback:@escaping ([Post]?)->Void){
        //get the local last update date
        let lud = Post.getLastUpdateDate();
        // delete the posts table
        Post.ClearTable(){() in
            //
            //get the cloud updates since the local update date
            self.modelFirebase.getMyPosts(userId: userId, since: lud) { (data) in
                //insert update to the local db
                var lud:Int64 = 0;
                if(data != nil){
                    for post in data!{
                        post.addToDb()
                        if post.lastUpdate! > lud {lud = post.lastUpdate!}
                    }
                }
                //update the students local last update date
                Post.setLastUpdate(lastUpdated: lud)
                // get the complete student list
                let finalData = Post.getMyPostsFromDb(userId: userId)
                callback(finalData);
                //
            };
        }
    }
    
    func saveImage(image:UIImage, postId: String, callback:@escaping (String)->Void) {
        FirebaseStorage.saveImage(image: image,postId: postId, callback: callback)
    }
    
}
class ModelEvents{
    static let PostDataEvent = EventNotificationBase(eventName: "Greener.PostDataEvent");
    static let LoggingStateChangeEvent = EventNotificationBase(eventName: "Greener.LoggingStateChangeEvent");
    
    static let CommentsDataEvent = StringEventNotificationBase<String>(eventName: "Greener.CommentsDataEvent");
    private init(){}
}

class EventNotificationBase{
    let eventName:String;
    
    init(eventName:String){
        self.eventName = eventName;
    }
    
    func observe(callback:@escaping ()->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                               object: nil, queue: nil) { (data) in
                                                callback();
        }
    }
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                        object: self,
                                        userInfo: nil);
    }
    func remove(){
        NotificationCenter.default.post(name: NSNotification.Name(eventName), object: self, userInfo: nil);
    }
}

class StringEventNotificationBase<T>{
    let eventName:String;
    
    init(eventName:String){
        self.eventName = eventName;
    }
    
    func observe(callback:@escaping (T)->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                               object: nil, queue: nil) { (data) in
                                                let strData = data.userInfo!["data"] as! T
                                                callback(strData);
        }
    }
    
    func post(data:T){
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                        object: self,
                                        userInfo: ["data":data]);
    }
}

