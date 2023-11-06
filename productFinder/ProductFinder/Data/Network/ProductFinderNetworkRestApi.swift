import Foundation

final class ProductFinderNetworkRestApi: NetworkBaseRestApi<Endpoint.ProductFinder,
    ProductFinderNetwork>,
    ProductFinderRestApi
{
    func fetchProducts(value: String) async throws -> SearchItem {
        let url = String(format: network.url(for: .search), value)

        guard let urlRequest = URL(string: url) else { throw APIError.defaultError }

        do {
            let (data, response) = try await session.data(from: urlRequest)
            if let status = (response as? HTTPURLResponse)?.statusCode {
                switch status {
                case HttpStatus.success:
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(SearchItem.self, from: data)

                    guard model.results.isEmpty else { return model }
                    throw APIError.noResult
                default:
                    throw APIError.defaultError
                }
            } else {
                throw APIError.defaultError
            }
        } catch {
            if let errorType = error as NSError? {
                switch errorType.code {
                case HttpStatus.offline, HttpStatus.connection:
                    throw APIError.connectionError
                default:
                    throw errorType
                }
            } else {
                throw error
            }
        }
    }

    func fetchProductDetail(id: String) async throws -> ItemDescription {
        let url = String(format: network.url(for: .detail), id)

        guard let urlRequest = URL(string: url) else { throw APIError.defaultError }

        do {
            let (data, response) = try await session.data(from: urlRequest)
            if let status = (response as? HTTPURLResponse)?.statusCode {
                switch status {
                case HttpStatus.success:
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(ItemDescription.self, from: data)
                    return model
                default:
                    throw APIError.defaultError
                }
            } else {
                throw APIError.defaultError
            }
        } catch {
            if let errorType = error as NSError? {
                switch errorType.code {
                case HttpStatus.offline, HttpStatus.connection:
                    throw APIError.connectionError
                default:
                    throw errorType
                }
            } else {
                throw error
            }
        }
    }
}
