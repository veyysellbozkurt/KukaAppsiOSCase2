//
//  CategoryViewModel.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import Foundation

class CategoryViewModel {
    
    var categories = [String]()
    
    func fetchCategories(completed: @escaping(Bool) -> ()) {
        let params: [String:Any] = [:]
        NetworkService.shared.fetchFakeStoreAndComplete(url: API.getCategories, param: params, method: .get) { response in
            switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completed(false)
                        return
                    }
                    do {
                        let categoryArray = try JSONDecoder().decode([String].self, from: data)
                        self.categories = categoryArray
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
