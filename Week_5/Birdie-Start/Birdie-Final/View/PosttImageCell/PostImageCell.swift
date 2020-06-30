//
//  PostImageCell.swift
//  Birdie-Final
//
//  Created by Andrés Carrillo on 29/06/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class PostImageCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var imageTweetView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell (_ post: ImagePost) {
        let date = post.timestamp
        usernameLabel.text = post.userName
        tweetLabel.text = post.textBody
        dateLabel.text = UDates.formatDate(date)
        imageTweetView.image = post.image
    }
    
}
