//
//  AuthorController.swift
//  
//
//  Created by Ke4a on 18.02.2023.
//

import Foundation
import Vapor

final class AuthorController {
    func getAuthor(_ req: Request) throws -> EventLoopFuture<AuthorResponse> {
        return req.eventLoop.future(AuthorResponse())
    }
}
