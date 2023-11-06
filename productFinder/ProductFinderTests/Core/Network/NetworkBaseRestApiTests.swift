@testable import ProductFinder
import XCTest

class NetworkBaseRestApiTests: TestCase {
    var sut: NetworkBaseRestApi<Endpoint.ProductFinder, ProductFinderNetwork>!

    override func setUp() {
        super.setUp()
        sut = NetworkBaseRestApi(
            domainNetwork: ProductFinderNetwork(),
            session: NetworkServiceLocator().session
        )
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNetwork() {
        XCTAssertNotNil(sut.network)
    }
}
