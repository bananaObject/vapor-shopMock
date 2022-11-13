//
//  DefaultUser.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Foundation

/// Фиктивные данные юзера будто из бд.
final class UserMock {
    let catalog: [Product]

    var id: Int = 0

    var login: String  = "admin"
    var password: String = "admin"
    var authToken: String = "905ef89d-25a4-4255-902f-fafd4f6a9774"

    var firstname: String = "Toxic"
    var lastname: String = "Frog"
    var email: String = "toxicFrog@gmail.com"
    var gender: String = "m"
    var creditCard: String = "9872389-2424-234224-234"
    var bio: String = "This is good! I think I will switch to another language"
    var basket: [Int: Int] = [:]

    init(_ catalog: [Product]) {
        self.catalog = catalog
    }

    func getBasket() -> [BasketResponse] {
        let array: [BasketResponse] = self.basket.compactMap { (key, value) in
            let index = key - 1
            
            guard self.catalog.indices.contains(index) else { return nil }

            let response = self.catalog[index].getResponseProductInfoNoDescription()
            return BasketResponse(quantity: value, product: response)
        }
        return array
    }

    func addItemInBasket(_ id: Int, qt: Int) {
        guard let temp = basket[id] else {
            basket[id] = qt
            return
        }

        basket[id] = temp + qt
    }

    func removeItemInBasket(_ id: Int) throws {
        guard let temp = basket[id] else { throw BasketError.noProductInBasket }

        guard temp >= 2 else {
            basket.removeValue(forKey: id)
            return
        }

        basket[id] = temp - 1
    }

    func clearBasket() {
        basket.removeAll()
    }

    /// User info update.
    /// - Parameter request: request
    func updateUserInfo(_ request: UserInfoRequest ) {
        self.firstname = request.firstname
        self.lastname = request.lastname
        self.email = request.email
        self.gender = request.gender
        self.creditCard = request.credit_card
        self.bio = request.bio
    }

    /// Reset user info (for test).
    func resetUserInfo() {
        self.firstname = "Toxic"
        self.lastname = "Frog"
        self.email = "toxicFrog@gmail.com"
        self.gender = "m"
        self.creditCard = "9872389-2424-234224-234"
        self.bio = "This is good! I think I will switch to another language"
    }

    /// User summary
    func getInfoForResponse() -> UserResponse {
        UserResponse(id: self.id,
                     login: self.login,
                     firstname: self.firstname,
                     lastname: self.lastname)
    }
}
