//
//  Episodes.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

struct Episode: Codable {
    
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let image: String
    
    public enum CodingKeys: String, CodingKey {
        case id, name, season, number, image
    }
    
    public enum ImagesKeys: String, CodingKey {
        case medium
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        season = try container.decode(Int.self, forKey: .season)
        number = try container.decode(Int.self, forKey: .number)
        
        let additionalInfo = try container.nestedContainer(keyedBy: ImagesKeys.self, forKey: .image)
        image = try additionalInfo.decode(String.self, forKey: .medium)
    }
}
