//
//  Error.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/28/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

/// Custom Error
///
/// - missingData: error that is being send when the app does not have all information needed
/// - missingError: error that is being send when a request has an error but no error description is provided
/// - parseError: error that is being send when the app was not able to parse a response

enum CustomError: Error {
    case missingData
    case missingError
    case parseError
}
