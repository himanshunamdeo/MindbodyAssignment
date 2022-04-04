//
//  NetworkManager.swift
//  MindbodyAssignment
//
//  Created by MeTaLlOiD on 04/04/22.
//

import Foundation

typealias CountriesCompletionHandler = ( _ countries: [Country]?, _ error: Error?) -> Void

struct CountriesAPIRequest {
    
    private var httpUtility: HttpUtility

    //Constructor injection: Injecting dependencies from the constructor itself
    init (httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func fetchCountries(completionHandler: @escaping CountriesCompletionHandler) {
        
        httpUtility.getAPIData(requestURL: baseURL, resultType: [Country].self) { result, error in
            completionHandler(result, error)
        }
    }
}
