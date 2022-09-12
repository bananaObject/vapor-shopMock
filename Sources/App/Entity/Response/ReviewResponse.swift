//
//  ReviewResponse.swift
//  
//
//  Created by Ke4a on 12.09.2022.
//

import Vapor

struct ReviewResponse: Content {
    let id_user: Int
    var id_review: Int
    let text: String
}
