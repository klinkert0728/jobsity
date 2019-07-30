//
//  APIClient.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/28/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import Alamofire

struct APIClient {
    
    static let sharedClient = APIClient()
    
    func requestJSONObject(endpoint: Endpoint, completionHandler: @escaping ResultClosure<Any>) {
        
        Alamofire.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.customParameterEncoding, headers: endpoint.customHTTPHeaders).responseJSON(completionHandler: { (response: DataResponse<Any>) in
            
            if let value = response.value, response.result.isSuccess, let currentStatusCode = response.response?.statusCode, (200...299 ~= currentStatusCode) {
                completionHandler(.success(value))
            } else {
                guard let responseData = response.data, let dictionaryObject = try? JSONSerialization.jsonObject(with: responseData, options: []), let dict = dictionaryObject as? StandardDictionary else {
                    completionHandler(.failure(CustomError.missingData))
                    return
                }
                
                let error = self.responseError(responseDictionary: dict, responseError: response.error)
                completionHandler(.failure(error))
            }
        })
    }
    
    func responseError(responseDictionary: StandardDictionary, responseError: Error?) -> Error {
        do {
            return try createErrorFromResponse(responseDictionary: responseDictionary, responseError: responseError)
        } catch CustomError.missingError {
            return CustomError.missingError
        } catch {
            return CustomError.missingData
        }
    }
    
    func createErrorFromResponse(responseDictionary: StandardDictionary, responseError: Error?) throws -> Error  {
        
        guard let error = responseError else {
            throw NSError(domain: "", code: 0, userInfo: [:])
        }
        return error
    }
}
