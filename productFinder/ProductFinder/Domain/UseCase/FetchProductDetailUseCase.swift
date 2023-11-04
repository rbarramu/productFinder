import Foundation

struct FetchProductDetailUseCase {
    private let repository: ProductFinderRepository

    init(repository: ProductFinderRepository) {
        self.repository = repository
    }

    func fetch(id: String) async throws -> ItemDescription {
        let response = try await repository.fetchProductDetail(id: id)
        return response
    }
}
