//
//  UserController.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Vapor

class UserController {
    weak private var dbMock: DataBaseMock?

    init(_ dbMock: DataBaseMock) {
        self.dbMock = dbMock
    }

    func create(_ req: Request) throws -> EventLoopFuture<ResultResponse> {
        guard let body = try? req.content.decode(UserDataRequest.self) else {
            throw Abort(.badRequest)
        }

        // выдает ошибку если в запросе пустое поле
        guard !body.login.isEmpty && !body.password.isEmpty
                && !body.firstname.isEmpty && !body.lastname.isEmpty
                && !body.email.isEmpty && !body.gender.isEmpty
                && !body.credit_card.isEmpty && !body.bio.isEmpty
        else {
            throw Abort(.badRequest, reason: "Empty required fields")
        }
        
        let response = ResultResponse(message: "Регистрация прошла успешно!")

        return req.eventLoop.future(response)
    }

    func changeUserData(_ req: Request) throws -> EventLoopFuture<ResultResponse> {
        guard let body = try? req.content.decode(UserDataRequest.self) else {
            throw Abort(.badRequest)
        }

        // выдает ошибку если в запросе пустое поле
        guard !body.login.isEmpty && !body.password.isEmpty
                && !body.firstname.isEmpty && !body.lastname.isEmpty
                && !body.email.isEmpty && !body.gender.isEmpty
                && !body.credit_card.isEmpty && !body.bio.isEmpty
        else {
            throw Abort(.badRequest, reason: "Empty required fields")
        }

        // изменяем данные в фиктивной бд.
        dbMock?.user.updateUserInfo(body)

        let response = ResultResponse(message: "Данные изменены!")

        return req.eventLoop.future(response)
    }
}
