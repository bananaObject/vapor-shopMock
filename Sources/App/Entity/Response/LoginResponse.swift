//
//  LoginResponse.swift
//
//
//  Created by Ke4a on 08.09.2022.
//

import Vapor

struct UserResponse: Content {
    let id_user: Int
    let login: String
    let firstname: String
    let lastname: String
}

struct LoginResponse: Content {
    let user: UserResponse
    let auth_token: String
}
