@testable import ProductFinder
import XCTest

class FetchProductDetailMapperTests: TestCase {
    var sut: FetchProductDetailMapper!

    override func setUp() {
        super.setUp()
        sut = FetchProductDetailMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testReverseMap() {
        guard let model = try? ItemDescription.mocked() else {
            fatalError("Failed to create model")
        }

        let viewModel = sut.reverseMap(value: model)
        XCTAssertEqual(model.text, viewModel.text)
    }
}
