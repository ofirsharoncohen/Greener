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
        
        //remove keyboard from view on tap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //if(userId == post?.userId)
        //{
        
        InfoPostNav.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(EditPost))
        //}
    }
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
    
    var picPath:String?;
    func UpdateImagePath(path:String){
        picPath = path;
    }
    
    @IBAction func savePost(_ sender: Any) {
        let post = Post(id:self.UserName.text!);
        post.content = self.postContent.text!
        guard let selectedImage = selectedImage else {
            Model.instance.add(post: post);
            self.navigationController?.popViewController(animated: true);
            return;
        }
        
        Model.instance.saveImage(image: selectedImage, postId: post.id) { (url) in
            post.pic = url;
            Model.instance.add(post: post);
            self.navigationController?.popViewController(animated: true);
        }
    }
    
//    @IBAction func savePost(_ sender: Any) {
//        if(isNew){
//            if let image = selectedImage{
//                Model.instance.saveImage(image: image, callback: UpdateImagePath)
//            }
//            post = Post(id: "123", userId: "bar", content: postContent.text, pic: "pic")
//            Model.instance.add(post: post!)
//        }
//    }
//
}
