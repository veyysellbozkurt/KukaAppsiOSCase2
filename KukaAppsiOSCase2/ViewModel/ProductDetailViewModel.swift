//
//  ProductDetailViewModel.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 6.08.2022.
//

import Foundation

class ProductDetailViewModel {
    
    var discountProducts = [DiscountProduct]()
    var products = [Product]()
    
    
    func fetchDiscountProducts(completed: @escaping(Bool) -> ()) {
        let params: [String:Any] = [:]
        
        NetworkService.shared.fetchOutfitsAndComplete(param: params, method: .get) { response in
            switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completed(false)
                        return
                    }
                    do {
                        let productArray = try JSONDecoder().decode([DiscountProduct].self, from: data)
                        self.discountProducts = productArray
                        for i in 0...self.discountProducts.count - 1 {
                            self.fetchDiscountProductByID(id: self.discountProducts[i].id!) { product in
                                self.products.append(product!)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                    if i == self.discountProducts.count - 1 {
                                        completed(true)
                                    }
                                }
                            }
                        }
                    } catch {
                        completed(false)
                    }
                case .failure(_): break
            }
        }
    }
    
    private func fetchDiscountProductByID(id: Int, completed: @escaping(Product?) -> ()) {
        let params: [String:Any] = [:]
        
        NetworkService.shared.fetchFakeStoreAndComplete(url: String(id), param: params, method: .get) { response in
            switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completed(nil)
                        return
                    }
                    do {
                        let product = try JSONDecoder().decode(Product.self, from: data)
                        completed(product)
                    } catch _{
                        completed(nil)
                    }
                case .failure(_):
                    break
            }
        }
    }
}
