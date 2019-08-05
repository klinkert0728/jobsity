//
//  Series.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/28/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import CoreData

/// Serie model that will represent a serie across the app.
struct Serie: Codable {
    
    let name: String
    let imageUrl: String
    let id: Int
    let summary: String
    let genres: [String]
    let schedule: SeriesSchedule
    let rating: Double
    var episodes: [Episode]
    
    
    public enum CodingKeys: String, CodingKey {
        case name, id, summary, genres, schedule, rating
        case imageUrl = "image"
        case episodes = "_embedded"
    }
    
    public enum ImagesKeys: String, CodingKey {
        case medium
    }
    
    public enum RatingKeys: String, CodingKey {
        case average
    }
    
    public enum EpisodesKeys: String, CodingKey {
        case episodes
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        summary  = try container.decode(String.self, forKey: .summary)
        genres = try container.decode([String].self, forKey: .genres)
        schedule = try container.decode(SeriesSchedule.self, forKey: .schedule)
        
        
        let imageInfo = try container.nestedContainer(keyedBy: ImagesKeys.self, forKey: .imageUrl)
        imageUrl = try imageInfo.decode(String.self, forKey: .medium)
        
        let ratingInfo = try container.nestedContainer(keyedBy: RatingKeys.self, forKey: .rating)
        rating = try ratingInfo.decodeIfPresent(Double.self, forKey: .average) ?? 0.0
        
        let additionalInfo = try? container.nestedContainer(keyedBy: EpisodesKeys.self, forKey: .episodes)
        episodes = try additionalInfo?.decodeIfPresent([Episode].self, forKey: .episodes) ?? []
    }
    
    /// Array of series that is being return from the API based on an specific page
    ///
    /// - Parameters:
    ///   - page: value to determine which page of the API should the app request
    ///   - completionHandler: Array of serie based on a page
    
    static func getSeries(with page: Int, completionHandler: @escaping ResultClosure<[Serie]>) {
        
        APIClient.sharedClient.requestJSONObject(endpoint: .getSeries(page: page)) { (result) in
            switch result {
            case .success(let networkResponse):
                guard let jsonResponseDict  = networkResponse as? [StandardDictionary] else {
                    completionHandler(.failure(CustomError.missingData))
                    return
                }
                do {
                    let data = try JSONSerialization.data(withJSONObject: jsonResponseDict, options: .prettyPrinted)
                    let series = try JSONDecoder().decode([Serie].self, from: data)
                    completionHandler(.success(series))
                } catch let error {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// Get a serie detail infromation
    ///
    /// - Parameters:
    ///   - id: selected serie id
    ///   - completionHandler: clousure that will contain the detailed information about the serie
    
    static func getDetail(with id: Int, completionHandler: @escaping ResultClosure<Serie>) {
        APIClient.sharedClient.requestJSONObject(endpoint: .getSerieDetail(id: id)) { (result) in
            switch result {
            case .success(let networkResponse):
                guard let jsonResponseDict  = networkResponse as? StandardDictionary else {
                    completionHandler(.failure(CustomError.missingData))
                    return
                }
                do {
                    let data = try JSONSerialization.data(withJSONObject: jsonResponseDict, options: .prettyPrinted)
                    let series = try JSONDecoder().decode(Serie.self, from: data)
                    completionHandler(.success(series))
                } catch let error {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

