//
//  NetworkService.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import Foundation
import Alamofire


protocol ServerResponseData {
    func onSuccess(data: Data)
    func onFailure(message: String)
}

class NetworkService {
    
    static let shared = NetworkService()
    
    
    func fetchFakeStoreAndComplete(url: String, param: [String: Any], method: HTTPMethod, completion: @escaping(DataResponse<Optional<Data>, AFError>) -> ()) {
        AF.request(API.baseUrl + url,
                   method: method, parameters: param,
                   headers: ["Accept": "application/json"]).response { response in
                completion(response)
        }
    }
    
    func fetchOutfitsAndComplete(param: [String: Any], method: HTTPMethod, completion: @escaping(DataResponse<Optional<Data>, AFError>) -> ()) {
        AF.request(API.fetchDiscount,
                   method: method, parameters: param,
                   headers: ["Accept": "application/json"]).response { response in
                completion(response)
        }
    }
}

