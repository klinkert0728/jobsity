//
//  ListSeriesTableViewCellViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import UIKit

struct ListCollectionViewCellViewModel: SeriesInformation {
    
    let bannerUrl: String
    let rating: Double
    let name: String
    let cellType: type
    
    let isFavorite: Bool
    var ratingImage: UIImage? {
        return UIImage(named: "rating")?.imageWithTintColor(color: UIColor.white)
    }
    
    var favoriteImage: UIImage? {
        return isFavorite ? UIImage(named: "fav_selected")?.imageWithTintColor(color: UIColor.white) : UIImage(named: "fav_unselected")?.imageWithTintColor(color: UIColor.white)
    }
    
    func setFavorite() {
        
    }
}
