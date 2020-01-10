//
//  FirebaseStorage.swift
//  Greener
//
//  Created by Studio on 10/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FirebaseStorage {
    static func saveImage(image:UIImage, callback:@escaping (String)->Void){
        let storageRef = Storage.storage().reference(forURL:
            "gs://greener-c532e.appspot.com")
        let data = image.jpegData(compressionQuality: 0.5)
        let imageRef = storageRef.child("imageName")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
    }
}
