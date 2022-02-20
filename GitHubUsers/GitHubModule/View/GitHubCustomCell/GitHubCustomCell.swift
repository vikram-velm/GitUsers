//
//  GitHubCustomCell.swift
//  GitHubUsers
//
//  Created by Vikram on 17/02/22.
//

import UIKit

class GitHubCustomCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userLink: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.black.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.clipsToBounds = true
    }
    
}
