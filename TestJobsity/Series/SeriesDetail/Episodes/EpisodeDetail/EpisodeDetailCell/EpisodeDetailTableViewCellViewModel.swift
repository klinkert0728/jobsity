//
//  EpisodeDetailTableViewCellViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

struct EpisodeDetailTableViewCellViewModel {
    let episode: Episode
    
    var episodeName: String {
        return episode.name + " " + "S\(episode.season)xE\(episode.number)"
    }
    
    var bannerImage: URL? {
        guard let url = URL(string: episode.image) else {
            return nil
        }
        return url
    }
    
    var summary: NSAttributedString? {
        return episode.summary.htmlText()
    }
}
