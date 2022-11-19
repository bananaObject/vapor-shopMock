//
//  Product.swift
//  
//
//  Created by Ke4a on 12.09.2022.
//

import Foundation


struct Product {
    let id: Int
    let category: Int
    let name: String
    let price: Int
    let description: String
    var reviews: [ReviewResponse]

    func getResponseProductInfoNoDescription() -> ProductResponse {
        return ProductResponse(id: self.id,
                               category: self.category,
                               name: self.name,
                               price: self.price,
                               description: nil,
                               last_review: nil)
    }

    func getResponseProductInfo() -> ProductResponse {
        return ProductResponse(id: self.id,
                               category: self.category,
                               name: self.name,
                               price: self.price,
                               description: self.description,
                               last_review: self.reviews.last)
    }
}
