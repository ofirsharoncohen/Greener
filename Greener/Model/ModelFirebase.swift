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
//        ref = db.collection("students").addDocument(data: json, completion: { err in
//                if let err = err {
//                    print("Error adding document: \(err)")
//                } else {
//                    print("Document added with ID: \(ref!.documentID)")
//                    ModelEvents.StudentDataEvent.post();
//                }
//        })
    }
    
    
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
