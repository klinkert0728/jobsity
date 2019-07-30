//
//  Error.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/28/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case missingData
    case missingError
    case parseError
    case failedAuth
}
