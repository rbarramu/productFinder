import Foundation

final class ProductFinderNetworkRestApi: NetworkBaseRestApi<Endpoint.ProductFinder, ProductFinderNetwork>, ProductFinderRestApi {
    func fetchProducts(value: String) async throws -> SearchItem {
        let url = String(format: network.url(for: .search), value)

        if let urlRequest = URL(string: url) {
            let (data, response) = try await session.data(from: urlRequest)

            if let status = (response as? HTTPURLResponse)?.statusCode, status == HttpStatus.success {
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(SearchItem.self, from: data)
                    return model
                } catch _ {
                    throw APIError.defaultError
                }
            } else {
                throw APIError.defaultError
            }
        } else {
            throw APIError.defaultError
        }
    }
}
