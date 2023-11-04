import Foundation

struct ItemList: Decodable {
    let id: String
    let title: String
    let price: Float
    let thumbnail: String
    let currencyId: String
    let originalPrice: Float?
    let acceptsMercadopago: Bool

    private enum CodingKeys: String, CodingKey {
        case id, title, price, thumbnail
        case currencyId = "currency_id"
        case originalPrice = "original_price"
        case acceptsMercadopago = "accepts_mercadopago"
    }
}
