//
//  ProvincesAPIRequest.swift
//  MindbodyAssignment
//
//  Created by MeTaLlOiD on 04/04/22.
//

import Foundation

typealias ProvincesCompletionHandler = ( _ provinces: [Province]?, _ error: Error?) -> Void

struct ProvincesAPIRequest {
    
    private var httpUtility: HttpUtility
    
    init (httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func fetchProvinces(countryID: Int, completionHandler: @escaping ProvincesCompletionHandler) {
        var requestURL = URL(string: baseURL)
        requestURL?.appendPathComponent(String(countryID))
        requestURL?.appendPathComponent("province")
        httpUtility.getAPIData(requestURL: requestURL!.absoluteString, resultType: [Province].self) { result, error in
            completionHandler(result, error)
        }
    }
}
