//
//  APIEndPoint.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/28/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import Alamofire

protocol APIEndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var customHTTPHeaders: [String: String]? { get }
    var customParameterEncoding: ParameterEncoding {get}
}

extension APIEndPoint {
    var url: URL {
        return baseURL.appendingPathComponent(path)
    }
}
