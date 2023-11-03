class ProductFinderNetwork: DomainNetworkBase<Endpoint.ProductFinder> {
    override func url(for endpoint: Endpoint.ProductFinder) -> String {
        baseBFFURL + endpoint.rawValue
    }
}
