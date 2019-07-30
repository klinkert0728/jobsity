//
//  MainInfoCollectionViewCell.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit
import AlamofireImage

class MainInfoCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainInfoCollectionViewCell"
    static let nib = "MainInfoCollectionViewCell"
    
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var selectedSummaryLabel: UILabel!
    
    var viewModel: MainInfoCollectionViewModel? {
        didSet {
            refreshUI()
        }
    }
    
    private func refreshUI() {
        guard let viewModel = viewModel else {
            return
        }
        selectedSummaryLabel.attributedText = viewModel.attributedString
        bannerImage.af_setImage(withURL: viewModel.bannerImageUrl)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
