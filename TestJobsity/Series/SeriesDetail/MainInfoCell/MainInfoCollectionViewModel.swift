//
//  MainInfoCollectionViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

struct MainInfoCollectionViewModel {
    let summary: String
    private let bannerStringUrl: String
    
    
    var bannerImageUrl: URL {
        guard let imageUrl = URL(string: bannerStringUrl) else {
            return URL(fileURLWithPath: "")
        }
        return imageUrl
    }
}
