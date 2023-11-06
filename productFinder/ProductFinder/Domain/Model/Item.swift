import Foundation

struct Item: Decodable {
    let id: String
    let title: String
    let price: Float
    let thumbnail: String
    let originalPrice: Float?
    let acceptsMercadopago: Bool

    private enum CodingKeys: String, CodingKey {
        case id, title, price, thumbnail
        case originalPrice = "original_price"
        case acceptsMercadopago = "accepts_mercadopago"
    }
}
