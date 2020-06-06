//
//  LoadingCell.swift
//  MNews
//
//  Created by admin on 07.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
