//
//  CurrencyTableViewCell.swift
//  ios-currency
//
//  Created by chulyeon kim on 2023/02/07.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
	
	@IBOutlet weak var leftLabel: UILabel!
	@IBOutlet weak var rightLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
