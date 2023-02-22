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
    var images: [String] = ["https://i.ibb.co/gwx9KRB/06764f7f-62e8-4672-8f7a-6ebc7af537df.png",
                            "https://i.ibb.co/b1wTNDR/076697a6-f720-4f94-b364-6853e9bd4083.png",
                            "https://i.ibb.co/vw8gvfh/C8f2a301-f844-4b77-948c-b842e85c7709.png",
                            "https://i.ibb.co/TbVSjQX/8c38e551-8cd0-41f8-9d3a-8d36b7a43243.png"]

    var smallImages: [String] = ["https://i.ibb.co/Qfj4y9M/06764f7f-62e8-4672-8f7a-6ebc7af537df.png",
                                 "https://i.ibb.co/nB7SZLQ/076697a6-f720-4f94-b364-6853e9bd4083.png",
                                 "https://i.ibb.co/sbckT9p/C8f2a301-f844-4b77-948c-b842e85c7709.png",
                                 "https://i.ibb.co/2jm4KMw/8c38e551-8cd0-41f8-9d3a-8d36b7a43243.png"]

    func getResponseProductInfoNoDescription() -> ProductResponse {
        return ProductResponse(id: self.id,
                               category: self.category,
                               name: self.name,
                               price: self.price,
                               description: nil,
                               last_review: nil,
                               qt: nil,
                               image: smallImages.randomElement())
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
