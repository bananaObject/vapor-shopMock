//
//  ProductResponse.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Vapor

struct ProductResponse: Content {
    let id_product: Int
    let id_category: Int
    let product_name: String
    let price: Int
    let product_description: String
}
