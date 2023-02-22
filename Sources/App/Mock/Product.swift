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
    var images: [String] = ["https://i.ibb.co/M6JGqvV/download.png",
                            "https://i.ibb.co/54BGczf/offer-hot-product-fire-svgrepo-com.png",
                            "https://i.ibb.co/DVN3cbx/product-delivery-ecommerce-svgrepo-com.png",
                            "https://i.ibb.co/frBw58P/pet-bath-product-svgrepo-com.png"]

    func getResponseProductInfoNoDescription() -> ProductResponse {
        return ProductResponse(id: self.id,
                               category: self.category,
                               name: self.name,
                               price: self.price,
                               description: nil,
                               last_review: nil,
                               qt: nil,
                               image: images[0])
    }

    func getResponseProductInfo(qt: Int) -> ProductResponse {
        return ProductResponse(id: self.id,
                               category: self.category,
                               name: self.name,
                               price: self.price,
                               description: self.description,
                               last_review: self.reviews.last,
                               qt: qt,
                               images: images)
    }
}
