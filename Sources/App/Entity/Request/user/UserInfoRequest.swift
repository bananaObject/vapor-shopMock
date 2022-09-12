//
//  UserInfoRequest.swift
//  
//
//  Created by Ke4a on 08.09.2022.
//

import Vapor

struct UserInfoRequest: Content {
    var login: String
    var password: String
    var firstname: String
    var lastname: String
    var email: String
    var gender: String
    var credit_card: String
    var bio: String
}
