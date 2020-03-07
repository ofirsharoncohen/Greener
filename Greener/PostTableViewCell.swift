//
//  PostTableViewCell.swift
//  Greener
//
//  Created by Studio on 01/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //the constraints of user.bottom picture.bottom and content.top
    @IBOutlet weak var userBottom: NSLayoutConstraint!

    @IBOutlet weak var picTop: NSLayoutConstraint!

    @IBOutlet weak var picHeight: NSLayoutConstraint!
    @IBOutlet weak var postPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postContent: UILabel!
   // @IBOutlet weak var postContent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
