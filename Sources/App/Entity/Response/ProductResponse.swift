//
//  ProductResponse.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Vapor

struct ProductResponse: Content {
    let id: Int
    let category: Int
    let name: String
    let price: Int
    let description: String?
    let last_review: ReviewResponse?
    let qt: Int?
    var image: String?
    var images: [String]?
}
