//
//  RepoCell.swift
//  OctoApp
//
//  Created by Tim on 10.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
