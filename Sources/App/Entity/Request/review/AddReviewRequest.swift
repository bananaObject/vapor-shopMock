//
//  AddReviewRequest.swift
//  
//
//  Created by Ke4a on 12.09.2022.
//

import Vapor

struct AddReviewRequest: Content {
    let auth_token: String
    let text: String
}
