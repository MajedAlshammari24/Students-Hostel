//
//  ServicesCell.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 04/05/1443 AH.
//

import UIKit

class ServicesCell: UITableViewCell {

    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var serviceDescription: UILabel!
    @IBOutlet weak var serviceImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
