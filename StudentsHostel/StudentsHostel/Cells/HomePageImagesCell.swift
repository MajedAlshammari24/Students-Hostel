//
//  HomePageImagesCell.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 15/05/1443 AH.
//

import UIKit

class HomePageImagesCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
