//
//  HttpUtility.swift
//  MindbodyAssignment
//
//  Created by MeTaLlOiD on 04/04/22.
//

import Foundation

typealias completionHandler<T:Decodable> = (_ result: T?,_ error: Error?) -> Void

struct HttpUtility {
    
    // Works with all Decodable types 
    func getAPIData<T: Decodable>(requestURL: String, resultType: T.Type, completionHandler: @escaping completionHandler<T> ) {
        
        let request = URLRequest(url: URL(string: requestURL)!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(nil, error)
            } else {
                if let response = response {
                    if (response as! HTTPURLResponse).statusCode == 200 {
                        if let data = data {
                            let decoder = JSONDecoder()
                            do {
                                let result = try decoder.decode(T.self, from: data)
                                completionHandler(result, nil)
                            } catch let exception {
                                completionHandler(nil, exception)
                            }
                        } else {
                            completionHandler(nil, NSError(domain: "Mindbody", code: 1, userInfo: [NSLocalizedDescriptionKey : "Corrupted Data"]))
                        }
                    }
                }
            }
        }.resume()
    }
}
