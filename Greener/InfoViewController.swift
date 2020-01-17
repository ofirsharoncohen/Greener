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
    
    var selectedImage:UIImage?
    var picPath:String?;
    var post:Post?
    var userId:String?
    var postId:String?
    var isNew:Bool = false
    var isEditable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserName.text = post?.userId
        postContent.text = post?.content
       // postPic.image = UIImage(named: "pic")
        
        
        //remove keyboard from view on tap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        if (isNew || isEditable)
        {
            EditPost()
        }
        else
        {
            InfoPostNav.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(EditPost))
        }
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.postPic.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }
    
    @objc func  EditPost()  {
        postContent.isEditable = true
        InfoPostNav.title = "New Post"
        postContent.text = "description"
        removePhoto.isHidden = false
        SavePost.isHidden = false
        UploadPhoto.isHidden = false
        postId = UUID().uuidString
        
        if (isEditable)
        {
            if post!.pic != "" {
                postPic.kf.setImage(with: URL(string: post!.pic));
            }
            postId = post?.id
            InfoPostNav.title = "Edit"
            postContent.text = post?.content;
        }
    }

    func UpdateImagePath(path:String){
        picPath = path;
    }
    
    @IBAction func savePost(_ sender: Any) {
        let NewPost = Post(id:postId!);// self.UserName.text!);
        NewPost.content = self.postContent.text!
        guard let selectedImage = selectedImage else {
            Model.instance.add(post: NewPost);
            self.navigationController?.popViewController(animated: true);
            return;
        }
        
        Model.instance.saveImage(image: selectedImage, postId: NewPost.id) { (url) in
            NewPost.pic = url;
            Model.instance.add(post: NewPost);
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
