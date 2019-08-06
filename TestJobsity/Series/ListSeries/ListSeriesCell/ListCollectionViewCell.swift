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
    @IBOutlet weak var rating: UIButton?
    @IBOutlet weak var favorite: UIButton?
    
    var selectedFavorite: (() -> ())?
    
    var viewModel: SeriesInformation? {
        didSet {
            refreshUI()
        }
    }
    
    private func refreshUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        if let url = viewModel.bannerImageUrl {
              bannerImage.af_setImage(withURL: url, placeholderImage: UIImage(named: "placeHolder"))
        } else {
            bannerImage.image = UIImage(named: "placeHolder")
        }
        
        name.text = viewModel.name
        
        if viewModel.cellType == .episode {
            rating?.removeFromSuperview()
            favorite?.removeFromSuperview()
        } else {
            let serieVieModel = viewModel as! ListCollectionViewCellViewModel
            rating?.setImage(serieVieModel.ratingImage, for: .normal)
            rating?.setTitle("\(serieVieModel.rating)", for: .normal)
            favorite?.setImage(serieVieModel.favoriteImage, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func setFavoriteSerie(_ sender: Any) {
        selectedFavorite?()
    }
}
