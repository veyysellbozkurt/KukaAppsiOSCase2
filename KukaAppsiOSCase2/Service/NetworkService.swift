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
    
    
    func fetchAndComplete(url: String, param: [String: Any], method: HTTPMethod, completion: @escaping(DataResponse<Optional<Data>, AFError>) -> ()) {
        AF.request(API.baseUrl + url,
                   method: method, parameters: param,
                   headers: ["Accept": "application/json"]).response { response in
            print("geldi", response.data?[4] as Any)
//            if let response = response {
                completion(response)
//            }
//            switch response.result {
//                case .success(let data):
//                        if data != nil {
//                            completion(.success(data!))
//                        }
//                case .failure(let error):
//                    completion(.failure(error))
//            }
        }
    }
}

