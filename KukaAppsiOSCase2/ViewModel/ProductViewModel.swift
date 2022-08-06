//
//  ProductViewModel.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import Foundation

class ProductViewModel {
    
    var products = [Product]()
    var isAscending = true
    
    func fetchProducts(categoryName: String, completed: @escaping(Bool) -> ()) {
        let sort = isAscending ? "asc" : "desc"
        let params: [String: Any] = ["sort": sort]
        
        NetworkService.shared.fetchFakeStoreAndComplete(url: API.getProducts + categoryName, param: params, method: .get) { response in
            switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completed(false)
                        return
                    }
                        do {
                            let productArray = try JSONDecoder().decode([Product].self, from: data)
                            self.products = productArray
                            completed(true)
                        } catch {
                            completed(false)
                        }
                case .failure(_):
                    break
            }
        }
    }
    
}
