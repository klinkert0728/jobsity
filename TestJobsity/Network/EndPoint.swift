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
        default:
            return "json"
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
        default:
            return nil
        }
    }
    
    var customParameterEncoding: ParameterEncoding {
        switch self {
        case .getSeries(page: _):
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
        
    }
    
    var customHTTPHeaders: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
