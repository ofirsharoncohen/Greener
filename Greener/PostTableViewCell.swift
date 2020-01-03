//
//  PostTableViewCell.swift
//  Greener
//
//  Created by Studio on 01/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
