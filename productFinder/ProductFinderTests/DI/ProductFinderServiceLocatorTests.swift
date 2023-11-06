@testable import ProductFinder
import XCTest

class ProductFinderServiceLocatorTests: TestCase {
    var sut: ProductFinderServiceLocator!

    override func setUp() {
        super.setUp()
        sut = ProductFinderServiceLocator()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testBranchServiceLocatorNotNil() {
        XCTAssertNotNil(sut)
    }

    func testBranchServiceLocatorHasUseCaseFetchProducts() {
        XCTAssertNotNil(sut.fetchProductsUseCase)
    }

    func testBranchServiceLocatorHasUseCaseFetchProductsDetail() {
        XCTAssertNotNil(sut.fetchProductDetailUseCase)
    }

    func testBranchServiceLocatorHasMapperFetchProducts() {
        XCTAssertNotNil(sut.fetchProductsMapper)
    }

    func testBranchServiceLocatorHasMapperFetchProductsDetail() {
        XCTAssertNotNil(sut.fetchProductDetailMapper)
    }
}
