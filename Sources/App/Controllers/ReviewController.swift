//
//  ReviewController.swift
//  
//
//  Created by Ke4a on 12.09.2022.
//

import Vapor

final class ReviewController {
    weak private var dbMock: DataBaseMock?

    private let itemOnPage = Constants.itemOnPage

    init(_ mock: DataBaseMock) {
        self.dbMock = mock
    }

    /// Get product reviews.
    ///
    /// query string:
    ///  - page_number  /  pagination
    ///
    /// parameters:
    ///  - id  / product
    ///
    /// - Parameter req: request
    /// - Returns: max page and items
    func getReviews(_ req: Request) throws  -> EventLoopFuture<ReviewsProductResponse> {
        guard let id = req.parameters.get("id"), let body = try? req.query.decode(ReviewsRequest.self) else {
            throw  Abort(.badRequest)
        }

        guard let reviews = dbMock?.catalog.first(where: { $0.id == Int(id) })?.reviews else {
            throw  Abort(.badRequest, reason: "there is no such product")
        }

        let userPage = body.page_number
        // Последняя страница
        let maxPage = Int((Double(reviews.count) / Double(itemOnPage)).rounded(.up))

        // выдает ошибку если выбранная страница больше максимальной
        guard userPage <= maxPage && userPage > 0 else {
            throw Abort(.badRequest, reason: "Wrong pagination page")
        }

        // срез каталога
        let arrayReviews = reviews[
            (userPage * itemOnPage - itemOnPage)..<(userPage == maxPage ? reviews.count : itemOnPage * userPage)]

        let response = ReviewsProductResponse(max_page: maxPage, items: Array(arrayReviews))

        return req.eventLoop.future(response)
    }

    /// Add review prdouct.
    ///
    /// json:
    /// - auth_token
    /// - text
    ///
    /// parameters:
    /// - id / product
    ///
    /// - Parameter req: request
    /// - Returns: review
    func addReview(_ req: Request) throws -> EventLoopFuture<ReviewResponse> {
        guard let id = req.parameters.get("id"), let body = try? req.content.decode(AddReviewRequest.self) else {
            throw Abort(.badRequest)
        }

        guard let index = dbMock?.catalog.firstIndex(where: {$0.id == Int(id)}) else {
            throw Abort(.badRequest, reason: "This product does not exist")
        }

        guard dbMock?.user.authToken == body.auth_token else {
            throw Abort(.forbidden, reason: "bad auth token")
        }

        let response = ReviewResponse(id_user: dbMock?.user.id ?? 0, id_review: Int.random(in: 200...10000), text: body.text)

        dbMock?.catalog[index].reviews.append(response)


        return req.eventLoop.future(response)
    }

    /// Delete review.
    ///
    /// json:
    /// - auth_token
    /// - id_review
    ///
    /// parameters:
    /// - id / product
    ///
    /// - Parameter req: request
    /// - Returns: message result
    func deleteReview(_ req: Request) throws -> EventLoopFuture<MessageResponse> {
        guard let id = req.parameters.get("id"), let body = try? req.content.decode(DeleteReviewRequest.self) else {
            throw Abort(.badRequest)
        }

        guard let index = dbMock?.catalog.firstIndex(where: {$0.id == Int(id)}),
              let indexReview = dbMock?.catalog[index].reviews.firstIndex(where: {$0.id_review == body.id_review}),
              let idUserReview = dbMock?.catalog[index].reviews[indexReview].id_user else {
            throw Abort(.badRequest, reason: "Product or review does not exist")
        }
        
        guard body.auth_token == dbMock?.user.authToken, idUserReview == dbMock?.user.id else {
            throw Abort(.forbidden, reason: "bad auth token")
        }

        dbMock?.catalog[index].reviews.remove(at: indexReview)

        let response = MessageResponse(message: "succes!")
        return req.eventLoop.future(response)
    }
}


