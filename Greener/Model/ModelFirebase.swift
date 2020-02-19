//
//  ModelFirebase.swift
//  Greener
//
//  Created by Studio on 10/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import Firebase

class ModelFirebase{
    
    func add(post:Post){
        let db = Firestore.firestore()
        //        var ref: DocumentReference? = nil
        let json = post.toJson();
        db.collection("posts").document(post.id).setData(json){
            err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                ModelEvents.PostDataEvent.post();
            }
        }
    }
    
    func remove(post:Post, callback:@escaping (Error?)->Void){
        //let uid = FIRAuth.auth()!.currentUser!.uid
        let db = Firestore.firestore()
        
        // Remove the post from the DB
        db.collection("posts").document(post.id).delete(){ error in
            if error != nil {
                callback(error);
            }
        }
        // Remove the image from storage
        if(post.pic != ""){
            let imageRef = storageRef.child(post.pic);
            imageRef.delete(completion: callback);
        }
    }
    
    lazy var storageRef = Storage.storage().reference(forURL:
        "gs://greener-c532e.appspot.com")
    
    //TODO: implement since
    func getAllPosts(since:Int64, callback: @escaping ([Post]?)->Void){
        let db = Firestore.firestore()
        db.collection("posts").order(by: "lastUpdate").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Post]();
                for document in querySnapshot!.documents {
                    if let ts = document.data()["lastUpdate"] as? Timestamp{
                        let tsDate = ts.dateValue();
                        print("\(tsDate)");
                        let tsDouble = tsDate.timeIntervalSince1970;
                        print("\(tsDouble)");
                    }
                    data.append(Post(json: document.data()));
                }
                callback(data);
            }
        };
    }
}
