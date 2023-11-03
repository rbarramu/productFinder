final class StubProductFinderService: StubServiceBase<Endpoint.ProductFinder, ProductFinderNetwork> {
    func stubAll() {
        stubFetchProducts()
    }

    private func stubFetchProducts() {
        let url = String(format: network.url(for: .search))
        addStub(url: url, fileName: #function, method: .get)
    }
}
