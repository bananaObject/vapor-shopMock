//
//  BasketController.swift
//  
//
//  Created by Ke4a on 15.09.2022.
//

import Vapor

class BasketController {
    // MARK: - Public Properties

    private let dbMock: DataBaseMock

    // MARK: - Initialization

    init(_ mock: DataBaseMock) {
        self.dbMock = mock
    }

    // MARK: - Public Methods

    func getBasket(_ req: Request) throws -> EventLoopFuture<[BasketResponse]> {
        guard let body = try? req.content.decode(BasketRequest.self) else {
            throw Abort(.badRequest)
        }

        guard dbMock.user.authToken == body.auth_token else {
            throw Abort(.forbidden, reason: "Bad auth token")
        }

        let response = dbMock.user.getBasket()
        return req.eventLoop.future(response)
    }

    func addItem(_ req: Request) throws -> EventLoopFuture<MessageResponse> {
        guard let body = try? req.content.decode(BasketRequest.self) else {
            throw Abort(.badRequest)
        }

        guard dbMock.user.authToken == body.auth_token else {
            throw Abort(.forbidden, reason: "Bad auth token")
        }

        guard let idProduct = body.id_product, dbMock.catalog.contains(where: {$0.id == idProduct}) else {
            throw Abort(.badRequest, reason: "This product does not exist")
        }

        guard let qt = body.quantity, qt > 0 else {
            throw Abort(.badRequest, reason: "Quantity cannot be less than one")
        }

        dbMock.user.addItemInBasket(idProduct, qt: qt)

        let response = MessageResponse(message: "Succes!")
        return req.eventLoop.future(response)
    }

    func removeItem(_ req: Request) throws -> EventLoopFuture<MessageResponse> {
        guard let body = try? req.content.decode(BasketRequest.self) else {
            throw Abort(.badRequest)
        }

        guard dbMock.user.authToken == body.auth_token else {
            throw Abort(.forbidden, reason: "Bad auth token")
        }

        guard let idProduct = body.id_product else {
            throw Abort(.badRequest, reason: "This product does not exist")
        }

        do {
            try dbMock.user.removeItemInBasket(idProduct)
        } catch {
            let error = error as? BasketError
            throw Abort(.badRequest, reason: error?.rawValue)
        }

        let response = MessageResponse(message: "Succes!")
        return req.eventLoop.future(response)
    }


    func removeAll(_ req: Request) throws -> EventLoopFuture<MessageResponse> {
        guard let body = try? req.content.decode(BasketRequest.self) else {
            throw Abort(.badRequest)
        }

        guard dbMock.user.authToken == body.auth_token else {
            throw Abort(.forbidden, reason: "Bad auth token")
        }

        dbMock.user.clearBasket()
        print(dbMock.user.basket)
        let response = MessageResponse(message: "Succes!")
        return req.eventLoop.future(response)
    }

    func pay(_ req: Request) throws -> EventLoopFuture<MessageResponse> {
        guard let body = try? req.content.decode(PayBasket.self) else {
            throw Abort(.badRequest)
        }

        guard dbMock.user.authToken == body.auth_token else {
            throw Abort(.forbidden, reason: "Bad auth token")
        }

        guard !dbMock.user.basket.isEmpty else {
            throw Abort(.forbidden, reason: "Empty basket")
        }

        guard !body.credit_card.isEmpty else {
            throw Abort(.forbidden, reason: "Bad credit card")
        }

        dbMock.user.clearBasket()

        let response = MessageResponse(message: "Покупка успешна!")
        return req.eventLoop.future(response)
    }
}
