enum ProductDetailCellType: CaseIterable {
    case image
    case title
    case originalPrice
    case price
    case descriptionTitle
    case description

    static let `default` = [image, title, originalPrice, price, descriptionTitle, description]
}
