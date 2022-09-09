//
//  CatalogController.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Vapor

class CatalogController {
    weak private var dbMock: DataBaseMock?
    private let productOnPage = 25

    init(_ dbMock: DataBaseMock) {
        self.dbMock = dbMock
    }

    func catalog(_ req: Request) throws -> EventLoopFuture<CatalogResponse> {
        guard let body = try? req.content.decode(CatalogRequst.self) else {
            throw Abort(.badRequest)
        }

        // выдает ошибку если отсутствует каталог в фиктивной бд
        guard let catalog = dbMock?.catalog else {
            throw Abort(.internalServerError)
        }

        let userPage = body.page_number
        // Максимальная страница
        let maxPage = Int((Double(catalog.count) / Double(productOnPage)).rounded(.up))

        // выдает ошибку если выбранная страница больше максимальной
        guard userPage <= maxPage && userPage > 0 else {
            throw Abort(.badRequest, reason: "Wrong pagination page")
        }

        // срез каталога
        let arrayProduct = catalog[
            (userPage * productOnPage - productOnPage)..<(userPage == maxPage ? catalog.count : productOnPage * userPage)]

        let response = CatalogResponse(page_number: userPage, max_page: maxPage, products: Array(arrayProduct))

        return req.eventLoop.future(response)
    }


    func product(_ req: Request) throws -> EventLoopFuture<ProductResponse> {
        guard let body = try? req.content.decode(ProductRequest.self) else {
            throw Abort(.badRequest)
        }

        // выдает ошибку если отсутствует каталог в фиктивной бд
        guard let catalog = dbMock?.catalog else {
            throw Abort(.internalServerError)
        }

        // выдает ошибку если отсутствует товар в фиктивной бд
        guard let response = catalog.first(where: { $0.id_product == body.id_product }) else {
            throw Abort(.badRequest, reason: "Такого товар не сущствует")
        }

        return req.eventLoop.future(response)
    }
}
