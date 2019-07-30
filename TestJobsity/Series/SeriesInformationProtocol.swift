//
//  SeriesInformationProtocol.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

enum type {
    case serie
    case episode
}

protocol SeriesInformation {
    var bannerUrl: String { get }
    var name: String { get }
    var cellType: type { get }
    
    var bannerImageUrl: URL? { get }
}

extension SeriesInformation {
    var bannerImageUrl: URL? {
        guard let imageUrl = URL(string: bannerUrl) else {
            return nil
        }
        return imageUrl
    }
}
