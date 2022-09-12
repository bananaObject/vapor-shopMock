import Vapor

let dbMock = DataBaseMock()

func routes(_ app: Application) throws {
    let userController = UserController(dbMock)
    let authController = AuthController(dbMock)
    let catalogController = CatalogController(dbMock)
    let reviewController = ReviewController(dbMock)
    
    app.post("auth", "login", use: authController.login)
    app.post("auth", "logout", use: authController.logout)

    app.post("user", "registration", use: userController.create)
    app.post("user", "changeInfo", use: userController.changeInfo)
    app.post("user", "resetInfo", use: userController.resetInfo)

    app.get("catalog", use: catalogController.catalog)
    app.get("catalog", "product", ":id", use: catalogController.product)

    app.get("catalog", "product", ":id", "reviews", use: reviewController.getReviews)
    app.post("catalog", "product", ":id", "review", "add", use: reviewController.addReview)
    app.post("catalog", "product", ":id", "review", "delete", use: reviewController.deleteReview)
}
