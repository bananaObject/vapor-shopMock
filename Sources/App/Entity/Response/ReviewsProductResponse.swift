//
//  ReviewsProductResponse.swift
//  
//
//  Created by Ke4a on 12.09.2022.
//

import Vapor

struct ReviewsProductResponse: Content {
    let max_page: Int
    let items: [ReviewResponse]
}
