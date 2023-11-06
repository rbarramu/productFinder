import Foundation

struct FetchProductsUseCase {
    private let repository: ProductFinderRepository

    init(repository: ProductFinderRepository) {
        self.repository = repository
    }

    func fetch(value: String) async throws -> SearchItem {
        let response = try await repository.fetchProducts(value: value)
        return response
    }
}
