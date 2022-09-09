import Vapor

let dbMock = DataBaseMock()

func routes(_ app: Application) throws {
    let userController = UserController(dbMock)
    let authController = AuthController(dbMock)
    let catalogController = CatalogController(dbMock)
    
    app.post("login", use: authController.login)
    app.post("logout", use: authController.logout)

    app.post("registration", use: userController.create)
    app.post("changeUserInfo", use: userController.changeUserInfo)
    app.get("resetUserInfo", use: userController.resetUserInfo)

    app.get("catalog", use: catalogController.catalog)
    app.get("product", use: catalogController.product)
}
