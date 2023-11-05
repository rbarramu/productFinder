class ItemViewModel {
    let id: String
    let title: String
    let price: Float
    let thumbnail: String
    let originalPrice: Float?
    let acceptsMercadopago: Bool

    init(
        id: String,
        title: String,
        price: Float,
        thumbnail: String,
        originalPrice: Float?,
        acceptsMercadopago: Bool
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
        self.originalPrice = originalPrice
        self.acceptsMercadopago = acceptsMercadopago
    }
}
