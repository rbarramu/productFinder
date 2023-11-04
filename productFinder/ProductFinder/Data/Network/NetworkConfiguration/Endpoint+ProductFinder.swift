enum Endpoint {
    enum ProductFinder: String {
        case search = "sites/MLC/search?q=%@"
        case detail = "items/%@/description"
    }
}
