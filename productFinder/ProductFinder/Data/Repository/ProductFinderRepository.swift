protocol ProductFinderRepository {
    func fetchProducts(value: String) async throws -> SearchItem
}
