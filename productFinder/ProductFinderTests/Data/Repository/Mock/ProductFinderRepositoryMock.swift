@testable import ProductFinder

class ProductFinderRepositoryMock: ProductFinderRepository {
    var success = true
    var noData = false
    var errorModel: APIError = .defaultError

    func fetchProducts(value _: String) async throws -> SearchItem {
        if noData {
            return SearchItem(results: [])
        }

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
