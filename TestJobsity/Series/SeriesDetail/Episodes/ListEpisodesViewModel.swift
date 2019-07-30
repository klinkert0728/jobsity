//
//  ListEpisodesViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

struct ListEpisodesViewModel: SeriesInformation {
    
    let bannerUrl: String
    let name: String
    let cellType: type
    let season: Int
    let number: Int
}
