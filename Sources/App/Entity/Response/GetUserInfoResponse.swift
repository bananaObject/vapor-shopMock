//
//  GetUserInfoResponse.swift
//  
//
//  Created by Ke4a on 08.11.2022.
//

import Vapor

struct GetUserInfoResponse: Content {
    var login: String
    var password: String
    var firstname: String
    var lastname: String
    var email: String
    var gender: String
    var creditCard: String
    var bio: String
}
