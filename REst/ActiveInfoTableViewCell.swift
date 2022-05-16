//
//  ActiveInfoTableViewCell.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/05/16.
//

import UIKit

class ActiveInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var labelDate: UILabel!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
}
