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
    
    func login(_ req: Request) throws -> EventLoopFuture<LoginResponse> {
        guard let body = try? req.content.decode(LoginRequest.self) else {
            throw Abort(.badRequest)
        }

        // Выдает ошибку если логин и пароль не совпадает с фиктивной бд
        guard dbMock?.user.login == body.login
                && dbMock?.user.password == body.password  else {
            throw Abort(.forbidden, reason: "Bad login and password")
        }

        // Выдает ошибку если отсутствует токен в фиктивной бд
        guard let userData = dbMock?.user.getInfoForResponse(), let token = dbMock?.authToken else {
            throw Abort(.internalServerError)
        }

        let response = LoginResponse(
            user: userData,
            auth_token: token
        )

        return req.eventLoop.future(response)
    }

    func logout(_ req: Request) throws -> EventLoopFuture<ResultResponse> {
        guard let body = try? req.content.decode(LogoutRequest.self) else {
            throw Abort(.badRequest)
        }

        // Выдает ошибку если не совпадает id и токен с фиктивной бд
        guard body.id_user == dbMock?.user.id_user
                && body.auth_token == dbMock?.authToken
        else {
            throw Abort(.unauthorized, reason: "Bad id or authToken")
        }

        let response = ResultResponse(message: "Вы успешно вышли из приложения")

        return req.eventLoop.future(response)
    }
}
