//
//  QuotesCell.swift
//  LifeQuotes
//
//  Created by Mag isb-10 on 20/02/2024.
//

import UIKit

class QuotesCell: UITableViewCell {
  
  @IBOutlet weak var img: UIImageView!
  @IBOutlet weak var quote: UILabel!
  @IBOutlet weak var author: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
