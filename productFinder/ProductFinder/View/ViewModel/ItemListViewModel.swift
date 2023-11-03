class ItemListViewModel {
    let id: String
    let title: String
    let price: Float
    let thumbnail: String

    init(
        id: String,
        title: String,
        price: Float,
        thumbnail: String
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
    }
}
