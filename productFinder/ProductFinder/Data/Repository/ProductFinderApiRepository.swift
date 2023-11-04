final class ProductFinderApiRepository: ProductFinderRepository {
    private var restApi: ProductFinderRestApi

    init(
        restApi: ProductFinderRestApi
    ) {
        self.restApi = restApi
    }

    func fetchProducts(value: String) async throws -> SearchItem {
        do {
            let response: SearchItem = try await restApi.fetchProducts(value: value)
            return response
        } catch {
            throw error
        }
    }

    func fetchProductDetail(id: String) async throws -> ItemDescription {
        do {
            let response: ItemDescription = try await restApi.fetchProductDetail(id: id)
            return response
        } catch {
            throw error
        }
    }
}
