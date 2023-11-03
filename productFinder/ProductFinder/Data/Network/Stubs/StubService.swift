import Foundation

class StubService {
    class func stubAll() {
        let productStubs = StubProductFinderService(domainNetwork: ProductFinderNetwork())
        productStubs.stubAll()
    }
}
