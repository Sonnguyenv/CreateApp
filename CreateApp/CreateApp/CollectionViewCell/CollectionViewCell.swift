//
//  CollectionViewCell.swift
//  CreateApp
//
//  Created by Sonnv on 3/4/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameVenueLable: UILabel!
    @IBOutlet weak var startTimeLable: UILabel!
    @IBOutlet weak var phtoView: UIImageView!
    @IBOutlet weak var nameDescriptionLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
