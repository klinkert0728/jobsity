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
    let bannerStringUrl: String
    let scheduleInfo: SeriesSchedule
    
    
    var attributedString: NSAttributedString? {
        var schedule = "On \(scheduleInfo.days.joined(separator: ","))" + "\n" + summary
        return schedule.htmlText()
    }
    
    var bannerImageUrl: URL {
        guard let imageUrl = URL(string: bannerStringUrl) else {
            return URL(fileURLWithPath: "")
        }
        return imageUrl
    }
}
