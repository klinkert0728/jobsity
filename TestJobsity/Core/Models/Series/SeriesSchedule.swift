//
//  SeriesSchedule.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/28/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

struct SeriesSchedule: Codable {
    let time: String
    let days: [String]
    
    public enum CodingKeys: String, CodingKey {
        case time, days
    }
    

    init() {
        time = ""
        days = []
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        time = try container.decode(String.self, forKey: .time)
        days = try container.decode([String].self, forKey: .days)
    }
}
