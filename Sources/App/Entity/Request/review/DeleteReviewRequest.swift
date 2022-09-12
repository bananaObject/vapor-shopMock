//
//  DeleteReviewRequest.swift
//  
//
//  Created by Ke4a on 12.09.2022.
//

import Vapor

struct DeleteReviewRequest: Content {
    let auth_token: String
    let id_review: Int
}
