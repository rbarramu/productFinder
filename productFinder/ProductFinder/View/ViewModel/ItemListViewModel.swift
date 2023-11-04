class ItemListViewModel {
    let id: String
    let title: String
    let price: Float
    let thumbnail: String
    let currencyId: String
    let originalPrice: Float?
    let acceptsMercadopago: Bool

    init(
        id: String,
        title: String,
        price: Float,
        thumbnail: String,
        currencyId: String,
        originalPrice: Float?,
        acceptsMercadopago: Bool
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
        self.currencyId = currencyId
        self.originalPrice = originalPrice
        self.acceptsMercadopago = acceptsMercadopago
    }
}
