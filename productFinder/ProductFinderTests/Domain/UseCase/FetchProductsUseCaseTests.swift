@testable import ProductFinder
import XCTest

class FetchProductsUseCaseTests: TestCase {
    var sut: FetchProductsUseCase!
    var repository: ProductFinderRepositoryMock!

    override func setUp() {
        super.setUp()
        repository = ProductFinderRepositoryMock()
        sut = FetchProductsUseCase(repository: repository)
    }

    override func tearDown() {
        sut = nil
        repository = nil
        super.tearDown()
    }

    func testFetchProductsSuccess() async {
        repository.success = true

        let response = try? await sut.fetch(value: "foo.value")
        XCTAssertNotNil(response)
    }

    func testFetchProductsFailure() async {
        repository.success = false

        let response = try? await sut.fetch(value: "foo.value")
        XCTAssertNil(response)
    }
}
