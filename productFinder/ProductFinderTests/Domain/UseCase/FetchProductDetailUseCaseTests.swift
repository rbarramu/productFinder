@testable import ProductFinder
import XCTest

class FetchProductDetailUseCaseTests: TestCase {
    var sut: FetchProductDetailUseCase!
    var repository: ProductFinderRepositoryMock!

    override func setUp() {
        super.setUp()
        repository = ProductFinderRepositoryMock()
        sut = FetchProductDetailUseCase(repository: repository)
    }

    override func tearDown() {
        sut = nil
        repository = nil
        super.tearDown()
    }

    func testFetchProductDetailSuccess() async {
        repository.success = true

        let response = try? await sut.fetch(id: "foo.id")
        XCTAssertNotNil(response)
    }

    func testFetchProductDetailFailure() async {
        repository.success = false

        let response = try? await sut.fetch(id: "foo.id")
        XCTAssertNil(response)
    }
}
