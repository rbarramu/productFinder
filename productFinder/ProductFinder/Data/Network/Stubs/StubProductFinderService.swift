final class StubProductFinderService: StubServiceBase<Endpoint.ProductFinder, ProductFinderNetwork> {
    func stubAll() {
        stubFetchProducts()
        stubFetchProductDetail()
    }

    private func stubFetchProducts() {
        let url = String(format: network.url(for: .search), "iphone")
        addStub(url: url, fileName: #function, method: .get, dataType: .dictionary)
    }

    private func stubFetchProductDetail() {
        let url = String(format: network.url(for: .detail), "MLC639996803")
        addStub(url: url, fileName: #function, method: .get, dataType: .dictionary)
    }
}
