//
//  DataBaseMock.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Foundation

/// Фиктивная база данных.
final class DataBaseMock {
    lazy var user: UserMock = UserMock(self.catalog)
    lazy var lorem1: String =  "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    lazy var lorem2: String = "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    lazy var images: [String] = ["https://i.ibb.co/gwx9KRB/06764f7f-62e8-4672-8f7a-6ebc7af537df.png",
                                 "https://i.ibb.co/b1wTNDR/076697a6-f720-4f94-b364-6853e9bd4083.png",
                                 "https://i.ibb.co/vw8gvfh/C8f2a301-f844-4b77-948c-b842e85c7709.png",
                                 "https://i.ibb.co/TbVSjQX/8c38e551-8cd0-41f8-9d3a-8d36b7a43243.png"]

    lazy var smallImages: [String] = ["https://i.ibb.co/Qfj4y9M/06764f7f-62e8-4672-8f7a-6ebc7af537df.png",
                                      "https://i.ibb.co/nB7SZLQ/076697a6-f720-4f94-b364-6853e9bd4083.png",
                                      "https://i.ibb.co/sbckT9p/C8f2a301-f844-4b77-948c-b842e85c7709.png",
                                      "https://i.ibb.co/2jm4KMw/8c38e551-8cd0-41f8-9d3a-8d36b7a43243.png"]


    var catalog: [Product] = []

    init() {
        self.catalog = self.createCatalog()
    }

    private func createCatalog() -> [Product] {
        var array: [Product] = []

        for index in (1...200) {
            let reviews = createReviews()
            var intRandom = Int.random(in: 0..<smallImages.endIndex)
            var image: String = smallImages[intRandom]
            var images: [String] = [images[intRandom]] + images[0..<images.endIndex - 1].enumerated().compactMap({ index, item in
                return index != intRandom ? item : nil
            })
            array.append(Product(id: index,
                                 category: index % 2 == 0 ? 1 : 2,
                                 name: "Товар \(index)",
                                 price: Int.random(in: 1000...99_000),
                                 description: Int.random(in: 1...5) % 2 == 0 ? lorem1 : lorem2,
                                 reviews: reviews,
                                 image: image,
                                 images: images))
        }
        return array
    }

    private func createReviews() -> [ReviewResponse] {
        var array: [ReviewResponse] = []

        for index in 0...40 {
            array.append(ReviewResponse(id_user: index, user_name: "Пользователь \(index)", id_review: index, text: Int.random(in: 1...5) % 2 == 0 ? lorem1 : lorem2))
        }

        return array
    }
}
