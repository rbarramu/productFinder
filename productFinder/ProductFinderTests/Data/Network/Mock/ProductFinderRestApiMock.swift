@testable import ProductFinder

class ProductFinderRestApiMock: ProductFinderRestApi {
    var success = true
    var errorModel: APIError = .defaultError

    func fetchProducts(value _: String) async throws -> SearchItem {
        if success {
            guard let entity = try? SearchItem.mocked() else {
                fatalError("Failed to create model")
            }
            return entity
        } else {
            throw errorModel
        }
    }

    func fetchProductDetail(id _: String) async throws -> ItemDescription {
        if success {
            guard let entity = try? ItemDescription.mocked() else {
                fatalError("Failed to create model")
            }
            return entity
        } else {
            throw errorModel
        }
    }
}
