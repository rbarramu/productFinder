@testable import ProductFinder
import XCTest

class FetchProductsMapperTests: TestCase {
    var sut: FetchProductsMapper!

    override func setUp() {
        super.setUp()
        sut = FetchProductsMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testReverseMap() {
        guard let model = try? SearchItem.mocked() else {
            fatalError("Failed to create model")
        }

        let viewModel = sut.reverseMap(value: model)

        for (index, result) in model.results.enumerated() {
            XCTAssertEqual(result.id, viewModel.results[index].id)
            XCTAssertEqual(result.title, viewModel.results[index].title)
            XCTAssertEqual(result.price, viewModel.results[index].price)
            XCTAssertEqual(result.thumbnail, viewModel.results[index].thumbnail)
            XCTAssertEqual(result.originalPrice, viewModel.results[index].originalPrice)
            XCTAssertEqual(result.acceptsMercadopago, viewModel.results[index].acceptsMercadopago)
        }
    }
}
