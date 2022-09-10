//
//  DataBaseMock.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Foundation

/// Фиктивная база данных.
class DataBaseMock {
    var user = UserMock()
    var catalog:[ProductResponse] = {
        var array:[ProductResponse] = []
        for index in (1...630) {
            array.append(
                ProductResponse(id: index,
                                category: index % 2 == 0 ? 1 : 2,
                                name: "Товар \(index)",
                                price: Int.random(in: 0...100_000),
                                description: "Мощный товар \(index)")
            )
        }
        return array
    }()
}
