//
//  DataBaseMock.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Foundation

/// Фиктивная база данных.
final class DataBaseMock {
    let user: UserMock

    var catalog: [Product] = []

    init() {
        self.user = UserMock()
        createCatalog()
    }

    private func createCatalog() {
        var array: [Product] = []

        for index in (1...200) {
            let reviews = createReviews()
            array.append(Product(id: index,
                                 category: index % 2 == 0 ? 1 : 2,
                                 name: "Товар \(index)",
                                 price: Int.random(in: 0...100_000),
                                 description: "Мощный товар \(index)",
                                 reviews: reviews)
            )
        }
        self.catalog = array
    }

    private func createReviews() -> [ReviewResponse] {
        var array: [ReviewResponse] = []

        for index in 0...40 {
            array.append(ReviewResponse(id_user: index, name_user: "Пользователь \(index)", id_review: index, text: "review \(index)"))
        }

        return array
    }
}
