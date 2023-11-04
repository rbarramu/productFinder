protocol ProductFinderRepository {
    func fetchProducts(value: String) async throws -> SearchItem
    func fetchProductDetail(id: String) async throws -> ItemDescription
}
