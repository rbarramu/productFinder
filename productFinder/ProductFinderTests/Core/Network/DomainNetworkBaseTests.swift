import Nimble
@testable import ProductFinder
import XCTest

class DomainNetworkBaseTests: TestCase {
    var sut: DomainNetworkBase<Endpoint.ProductFinder>!

    override func setUp() {
        super.setUp()
        sut = DomainNetworkBase<Endpoint.ProductFinder>()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testUrl() {
        #if canImport(Darwin) && (arch(x86_64) || arch(arm64))
            expect { _ = self.sut.url(for: .search) }.to(throwAssertion())
        #endif
    }

    func testParameters() {
        #if canImport(Darwin) && (arch(x86_64) || arch(arm64))
            expect { _ = self.sut.parameters(for: .search, params: nil) }.to(throwAssertion())
        #endif
    }

    func testBaseBFFURL() {
        Environment.all.forEach {
            sut = DomainNetworkBase<Endpoint.ProductFinder>(environment: $0)
            XCTAssertNotNil(sut.baseBFFURL)
        }
    }
}
