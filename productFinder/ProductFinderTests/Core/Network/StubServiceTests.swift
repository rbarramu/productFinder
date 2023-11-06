import Mimic
@testable import ProductFinder
import XCTest

class StubServiceTests: TestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testStubAll() {
        // StubService.stubAll()
        // assertSuperHeroesStubsService()
    }

    private func assertSuperHeroesStubsService() {
        let network = ProductFinderNetwork(environment: .stubbed)

        var request = URLRequest(url: URL(string: network.url(for: .search))!)
        request.httpMethod = MimicHTTPMethod.get.description
        XCTAssertTrue(MimicProtocol.canInit(with: request))
    }
}
