import Foundation

final class ProductFinderNetworkRestApi: NetworkBaseRestApi<Endpoint.ProductFinder,
    ProductFinderNetwork>,
    ProductFinderRestApi
{
    func fetchProducts(value: String) async throws -> SearchItem {
        let url = String(format: network.url(for: .search), value)

        guard let urlRequest = URL(string: url) else {
            throw APIError.defaultError
        }

        let (data, response) = try await session.data(from: urlRequest)

        print(response)
        
        if let status = (response as? HTTPURLResponse)?.statusCode {
            switch status {
            case HttpStatus.success:
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(SearchItem.self, from: data)

                    guard model.results.isEmpty else {
                        return model
                    }

                    throw APIError.noResult
                } catch _ {
                    throw APIError.defaultError
                }
            case HttpStatus.offline, HttpStatus.connection:
                throw APIError.connectionError
            default:
                throw APIError.defaultError
            }
        } else {
            throw APIError.defaultError
        }
    }

    func fetchProductDetail(id: String) async throws -> ItemDescription {
        let url = String(format: network.url(for: .detail), id)

        if let urlRequest = URL(string: url) {
            let (data, response) = try await session.data(from: urlRequest)

            if let status = (response as? HTTPURLResponse)?.statusCode, status == HttpStatus.success {
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(ItemDescription.self, from: data)
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
