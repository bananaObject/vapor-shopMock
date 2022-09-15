//
//  PayBasket.swift
//  
//
//  Created by Ke4a on 15.09.2022.
//

import Vapor

struct PayBasket: Content {
    let credit_card: String
    let auth_token: String
}
