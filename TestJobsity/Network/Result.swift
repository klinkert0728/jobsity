//
//  Result.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/28/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

typealias ResultClosure<ResultType> = (Result<ResultType>) -> ()
public typealias StandardDictionary = [String: Any]

enum Result<ResultType> {
    case success(ResultType)
    case failure(Error)
}


extension Result where ResultType == Void {
    static var success: Result {
        return .success(())
    }
}
