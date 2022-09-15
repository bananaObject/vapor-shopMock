//
//  BasketRequest.swift
//  
//
//  Created by Ke4a on 15.09.2022.
//

import Vapor

struct BasketRequest: Content {
    let auth_token: String
    let id_product: Int?
}
