//
//  InfoViewController.swift
//  Greener
//
//  Created by Studio on 08/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var postPic: UIImageView!
    @IBOutlet weak var postContent: UITextView!
    
    @IBOutlet weak var SavePost: UIButton!
    @IBOutlet weak var removePhoto: UIButton!
    @IBOutlet weak var UploadPhoto: UIButton!
    @IBOutlet weak var InfoPostNav: UINavigationItem!
    
    var post:Post?
    var userId:String?
    var isNew:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserName.text = post?.userId
        postContent.text = post?.content
        postPic.image = UIImage(named: "Recycle")
        
        //if(userId == post?.userId)
        //{
                    
            InfoPostNav.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(EditPost))
        //}
    }
    
    @IBAction func TakePic(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
           let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
           imagePicker.sourceType =
            UIImagePickerController.SourceType.photoLibrary;
           imagePicker.allowsEditing = true
           self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    var selectedImage:UIImage?
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
           self.postPic.image = selectedImage;
           dismiss(animated: true, completion: nil);
       }
    
    @objc func  EditPost()  {
        postContent.isEditable = true
        removePhoto.isHidden = false
        SavePost.isHidden = false
        UploadPhoto.isHidden = false
        InfoPostNav.title = "Edit"
    }
    
    
    @IBAction func savePost(_ sender: Any) {
        if(isNew){
            post = Post(id: "123", userId: "bar", content: postContent.text, pic: "pic")
            Model.instance.add(post: post!)
        }
    }
    
    /*
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
