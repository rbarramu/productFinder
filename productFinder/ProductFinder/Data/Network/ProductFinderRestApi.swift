protocol ProductFinderRestApi: AnyObject {
    func fetchProducts(value: String) async throws -> SearchItem
}
