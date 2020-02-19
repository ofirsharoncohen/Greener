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
    
    @IBOutlet weak var DeletePost: UIButton!
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
        if post?.pic != "" && ((post?.pic) != nil) {
            postPic.kf.setImage(with: URL(string: post!.pic));
        }
        
        //remove keyboard from view on tap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if (isNew || isEditable)
        {
            EditPost()
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
    @IBAction func DeletePic(_ sender: Any) {
        self.postPic.image = nil;
        selectedImage = nil
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.postPic.image = selectedImage;
        removePhoto.isHidden = false
        dismiss(animated: true, completion: nil);
    }
    
    @objc func  EditPost()  {
        postContent.isEditable = true
        InfoPostNav.title = "New Post"
        //postContent.pl = "description"
        removePhoto.isHidden = true
        SavePost.isHidden = false
        
        UploadPhoto.isHidden = false
        postId = UUID().uuidString
        UserName.text = userId
        
        if (isEditable)
        {
            if post!.pic != "" {
                removePhoto.isHidden = false
            }
            DeletePost.isHidden = false
            postId = post?.id
            InfoPostNav.title = "Edit"
            postContent.text = post?.content;
        }
    }
    
    func UpdateImagePath(path:String){
        picPath = path;
    }
    
    @IBAction func deletePost(_ sender: Any) {
        DeletePost.isEnabled = false
        let OldPost = post
        Model.instance.remove(post: OldPost!){ error in
            if(error != nil){
                let alert = UIAlertController(title: "error", message: "Error: \(error.debugDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                self.navigationController?.popViewController(animated: true);
            }
        };
    }
    
    @IBAction func savePost(_ sender: Any) {
        SavePost.isEnabled = false
        if self.postContent.text == "" {
            let alert = UIAlertController(title: "error", message: "Post can't be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            SavePost.isEnabled = true
            return
        }
        let NewPost = Post(id:postId!);// self.UserName.text!);
        NewPost.content = self.postContent.text!
        NewPost.userId = self.userId!
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
    
    
}
