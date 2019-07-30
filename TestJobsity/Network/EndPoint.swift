//
//  EndPoint.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/28/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum requestConstants {
    
    enum constantUrls {
        static let baseUrl = "http://api.tvmaze.com/"
    }
    
    enum paths {
        static let shows = "shows?page="
    }
}

enum Endpoint {
    case getSeries(page: Int)
    case getSerieDetail(id: Int)
}

extension Endpoint: APIEndPoint {
   
    var baseURL: URL {
        switch self {
        default:
            return URL(string: requestConstants.constantUrls.baseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .getSeries(page: _):
            return "shows"
        case  .getSerieDetail(id: let id):
            return "shows/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getSeries(page: let page):
            return ["page": page]
        case .getSerieDetail(id: _):
            return ["embed": "episodes"]
        }
    }
    
    var customParameterEncoding: ParameterEncoding {
        switch self {
        case .getSeries(page: _), .getSerieDetail(id: _):
            return URLEncoding.default
        }
        
    }
    
    var customHTTPHeaders: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
