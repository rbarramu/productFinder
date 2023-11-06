@testable import ProductFinder

class ProductFinderRestApiMock: ProductFinderRestApi {
    var success = true
    var errorModel: APIError = .defaultError

    func fetchProducts(value _: String) async throws -> SearchItem {
        if success {
            return SearchItem(results: [Item(
                id: "foo.id",
                title: "foo.title",
                price: 0.0,
                thumbnail: "foo.thumbnail",
                originalPrice: 0.0,
                acceptsMercadopago: true
            )])
        } else {
            throw errorModel
        }
    }

    func fetchProductDetail(id _: String) async throws -> ItemDescription {
        if success {
            return ItemDescription(text: "foo.text")
        } else {
            throw errorModel
        }
    }
}
