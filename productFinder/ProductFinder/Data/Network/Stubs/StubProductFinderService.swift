final class StubProductFinderService: StubServiceBase<Endpoint.ProductFinder, ProductFinderNetwork> {
    func stubAll() {
        stubFetchProducts()
    }

    private func stubFetchProducts() {
        let url = String(format: network.url(for: .search), "iphone")
        addStub(url: url, fileName: #function, method: .get, dataType: .dictionary)
    }
}
