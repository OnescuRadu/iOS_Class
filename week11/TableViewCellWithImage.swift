//
//  TableViewCellWithImage.swift
//  CustomCellDemo
//
//  Created by Radu Onescu on 13/03/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

class TableViewCellWithImage: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myLabel.text = "radu"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
