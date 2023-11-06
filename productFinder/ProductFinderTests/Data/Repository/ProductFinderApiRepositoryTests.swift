@testable import ProductFinder
import XCTest

class ProductFinderApiRepositoryTests: TestCase {
    var sut: ProductFinderApiRepository!
    var restApiMock: ProductFinderRestApiMock!

    override func setUp() {
        super.setUp()
        restApiMock = ProductFinderRestApiMock()

        sut = ProductFinderApiRepository(restApi: restApiMock)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetFetchProductsSuccess() async {
        restApiMock.success = true

        let response = try? await sut.fetchProducts(value: "foo.value")
        XCTAssertNotNil(response)
    }

    func testGetFetchProductsFailure() async {
        restApiMock.success = false

        do {
            _ = try await sut.fetchProducts(value: "foo.value")
            XCTFail("this line should not be reachable")
        } catch {
            XCTAssertNotNil(error)
            XCTAssertTrue(error is APIError)
        }
    }

    func testGetFetchProductDetailSuccess() async {
        restApiMock.success = true

        let response = try? await sut.fetchProductDetail(id: "foo.id")
        XCTAssertNotNil(response)
    }

    func testGetFetchProductDetailFailure() async {
        restApiMock.success = false

        do {
            _ = try await sut.fetchProductDetail(id: "foo.id")
            XCTFail("this line should not be reachable")
        } catch {
            XCTAssertNotNil(error)
            XCTAssertTrue(error is APIError)
        }
    }
}
