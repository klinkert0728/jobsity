//
//  ListSeriesTableViewCellViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import UIKit

struct ListCollectionViewCellViewModel {
    let bannerUrl: String
    let rating: Double
    let name: String
    
    
    var bannerImageUrl: URL {
        guard let imageUrl = URL(string: bannerUrl) else {
            return URL(fileURLWithPath: "")
        }
        return imageUrl
    }
    
    var ratingImage: UIImage? {
        return UIImage(named: "")
    }
    
    
    func setFavorite() {
        
    }
}
