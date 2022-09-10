//
//  AuthController.swift.swift
//  
//
//  Created by Ke4a on 08.09.2022.
//

import Vapor

class AuthController {
    weak private var dbMock: DataBaseMock?
    
    init(_ dbMock: DataBaseMock) {
        self.dbMock = dbMock
    }
    
    /// Login.
    ///
    /// json body:
    ///  - login
    ///  - password
    ///
    ///  Validates login and pass.
    ///
    /// - Parameter req: request
    /// - Returns: User info and auth token.
    func login(_ req: Request) throws -> EventLoopFuture<LoginResponse> {
        guard let body = try? req.content.decode(LoginRequest.self) else {
            throw Abort(.badRequest)
        }

        // Выдает ошибку если логин и пароль не совпадает с фиктивной бд
        guard dbMock?.user.login == body.login
                && dbMock?.user.password == body.password
        else {
            throw Abort(.forbidden, reason: "Bad login and password")
        }
        
        // Выдает ошибку если отсутствует в фиктивной бд
        guard let userData = dbMock?.user.getInfoForResponse(),
              let token = dbMock?.user.authToken
        else {
            throw Abort(.internalServerError)
        }
        
        let response = LoginResponse(
            user: userData,
            auth_token: token
        )
        
        return req.eventLoop.future(response)
    }
    
    /// Logout.
    /// 
    /// json body:
    /// - id
    /// - auth_token
    ///
    /// Checking the validity of the user id and token.
    /// - Parameter req: request
    /// - Returns: result message
    func logout(_ req: Request) throws -> EventLoopFuture<MessageResponse> {
        guard let body = try? req.content.decode(LogoutRequest.self) else {
            throw Abort(.badRequest)
        }
        
        // Выдает ошибку если не совпадает id и токен с фиктивной бд
        guard body.auth_token == dbMock?.user.authToken else {
            throw Abort(.unauthorized, reason: "Bad id or authToken")
        }
        
        let response = MessageResponse(message: "Вы успешно вышли из приложения")
        
        return req.eventLoop.future(response)
    }
}
