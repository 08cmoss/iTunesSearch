//
//  iTunesTableViewCell.swift
//  iTunesSearch
//
//  Created by Cameron Moss on 8/6/18.
//  Copyright © 2018 Cameron Moss. All rights reserved.
//

import UIKit

class iTunesTableViewCell: UITableViewCell {
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var mediaTitle: UILabel!
    @IBOutlet weak var mediaGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
