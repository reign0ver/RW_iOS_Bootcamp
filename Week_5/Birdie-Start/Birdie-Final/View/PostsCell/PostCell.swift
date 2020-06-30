//
//  PostCell.swift
//  Birdie-Final
//
//  Created by Andrés Carrillo on 29/06/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell (_ post: TextPost) {
        let date = post.timestamp
        usernameLabel.text = post.userName
        dateLabel.text = UDates.formatDate(date)
        tweetLabel.text = post.textBody
    }
    
}
