//
//  LogoutRequest.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Vapor

struct LogoutRequest: Content {
    let auth_token: String
}
