//
//  DataBaseMock.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Foundation

/// Фиктивная база данных.
class DataBaseMock {
    let authToken: String = "905ef89d-25a4-4255-902f-fafd4f6a9774"
    var user = UserMock()
    var catalog:[ProductResponse] = {
        var array:[ProductResponse] = []
        for index in (1...630) {
            array.append(
                ProductResponse(id_product: index,
                                id_category: index % 2 == 0 ? 1 : 2,
                                product_name: "Товар \(index)",
                                price: Int.random(in: 0...100_000),
                                product_description: "Мощный товар \(index)")
            )
        }
        return array
    }()
}
