//
//  PostTableViewCellWithPic.swift
//  Greener
//
//  Created by Bar Kazzaz on 09/09/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class PostTableViewCellWithPic: PostTableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postPic: UIImageView!
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
