//
//  BasketResponse.swift
//  
//
//  Created by Ke4a on 15.09.2022.
//

import Vapor

struct BasketResponse: Content {
    let quantity: Int
    let product: ProductResponse
}
