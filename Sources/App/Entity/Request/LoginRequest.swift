//
//  LoginRequest.swift
//
//
//  Created by Ke4a on 08.09.2022.
//

import Vapor

struct LoginRequest: Content{
    var login: String
    var password: String
}
