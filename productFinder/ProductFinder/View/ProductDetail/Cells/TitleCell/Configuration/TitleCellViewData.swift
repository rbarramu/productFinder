struct TitleCellViewData {
    let title: String
    let isStrikethrough: Bool?

    init(
        title: String,
        isStrikethrough: Bool? = false
    ) {
        self.title = title
        self.isStrikethrough = isStrikethrough
    }
}
