//
//  CatalogController.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Vapor

class CatalogController {
    weak private var dbMock: DataBaseMock?
    /// Number of elements on the screen
    private let productOnPage = 25

    init(_ dbMock: DataBaseMock) {
        self.dbMock = dbMock
    }

    /// Catalog product.
    ///
    /// query string:
    /// - page_number  - pagination (required)
    /// - category  - filter by category
    /// - Parameter req: Request
    /// - Returns: Massive products.
    func catalog(_ req: Request) throws -> EventLoopFuture<CatalogResponse> {
        guard let body = try? req.query.decode(CatalogRequst.self) else {
            throw Abort(.badRequest)
        }

        // выдает ошибку если отсутствует каталог в фиктивной бд
        guard let mockCatalog  = dbMock?.catalog else {
            throw Abort(.internalServerError)
        }

        let catalog: [ProductResponse]

        // если есть категория то фильтруется каталог
        if let category = body.id_category {
            catalog = mockCatalog.filter{ $0.category == category }
        } else {
            catalog = mockCatalog
        }

        let userPage = body.page_number
        // Последняя страница
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


    /// Product.
    ///
    /// parameters:
    /// - id - finds the product id from the parameter.
    /// - Parameter req: request
    /// - Returns: product
    func product(_ req: Request) throws -> EventLoopFuture<ProductResponse> {
        guard let id = req.parameters.get("id") else {
            throw Abort(.badRequest)
        }

        // выдает ошибку если отсутствует каталог в фиктивной бд
        guard let catalog = dbMock?.catalog else {
            throw Abort(.internalServerError)
        }

        // выдает ошибку если отсутствует товар в фиктивной бд
        guard let response = catalog.first(where: { $0.id == Int(id) }) else {
            throw Abort(.badRequest, reason: "This product does not exist")
        }

        return req.eventLoop.future(response)
    }
}
