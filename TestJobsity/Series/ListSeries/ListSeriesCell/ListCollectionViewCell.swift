//
//  ListCollectionViewCell.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit
import AlamofireImage

class ListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCollectionViewCell"
    static let nibName = "ListCollectionViewCell"

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UIButton!
    @IBOutlet weak var favorite: UIButton!
    
    var viewModel: ListCollectionViewCellViewModel? {
        didSet {
            refreshUI()
        }
    }
    
    private func refreshUI() {
        guard let viewmModel = viewModel else {
            return
        }
        bannerImage.af_setImage(withURL: viewmModel.bannerImageUrl)
        name.text = viewmModel.name
        rating.setImage(viewmModel.ratingImage, for: .normal)
        rating.setTitle("\(viewmModel.rating)", for: .normal)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
