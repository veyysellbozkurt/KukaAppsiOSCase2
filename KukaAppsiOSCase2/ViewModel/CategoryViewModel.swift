//
//  CategoryViewModel.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import Foundation
import Alamofire

class CategoryViewModel {
    
    var categories = [String]()
    
    func fetchCategories(completed: @escaping(Bool) -> ()) {
        let params: [String:Any] = [:]
        NetworkService.shared.fetchAndComplete(url: API.getCategories, param: params, method: .get) { response in
            switch response.result {
                case .success(let data):
                    if data != nil {
                        do {
                            let adam = try JSONDecoder().decode([String].self, from: data!)
                            print("akd", adam)
                            self.categories = adam
                            completed(true)
                        } catch let error{
                            completed(false)
                            print("hata", error.localizedDescription)
                        }
                    } else {
                        completed(false)
                    }
                case .failure(let error):
                    print("hata var", error)
            }
        }
    }
    
}
