//
//  EditPostViewController.swift
//  Greener
//
//  Created by Studio on 01/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class EditPostViewController: UIViewController {

    @IBOutlet weak var BackButton: UINavigationItem!
    @IBOutlet weak var postPic: UIImageView!
    @IBOutlet weak var contentPost: UITextView!
    
    var post:Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.post != nil{
            self.contentPost.text = post?.content;
        // Do any additional setup after loading the view.
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
