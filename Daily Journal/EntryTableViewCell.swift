//
//  EntryTableViewCell.swift
//  Daily Journal
//
//  Created by qualson1 on 2022/06/29.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet var entryTextLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
