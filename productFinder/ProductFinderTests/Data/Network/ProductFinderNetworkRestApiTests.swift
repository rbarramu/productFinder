import Mimic
@testable import ProductFinder
import XCTest

class ProductFinderNetworkRestApiTests: TestCase {
    var sut: ProductFinderNetworkRestApi!

    override func setUp() {
        super.setUp()
        sut = ProductFinderNetworkRestApi(
            domainNetwork: ProductFinderNetwork(environment: .stubbed),
            session: NetworkServiceLocator().session
        )
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetFetchProductsSuccess() async {
        let url = String(format: sut.network.url(for: .search), "foo.search")
        let body = readJSON(fileName: "GET_FetchProducts_200")
        stub(http(.get, uri: url), json(body, status: 200))

        do {
            let response = try await sut.fetchProducts(value: "foo.search")
            XCTAssertTrue(response.results.count > .zero)

            let result = response.results.first
            XCTAssertEqual(result?.id, "MLC639996803")
            XCTAssertEqual(result?.title, "Apple iPhone 11 (64 Gb) - Blanco")
            XCTAssertEqual(result?.price, 359_990.0)
            XCTAssertEqual(result?.thumbnail, "http://http2.mlstatic.com/D_621305-MLA46153276312_052021-I.jpg")
            XCTAssertEqual(result?.originalPrice, 669_990.0)
            XCTAssertEqual(result?.acceptsMercadopago, true)
        } catch {
            XCTFail("This line shouldn't be reached")
            return
        }
    }

    func testGetFetchProductsFailure() async {
        let url = String(format: sut.network.url(for: .search), "foo.search")
        let body = readJSON(fileName: "GET_FetchProducts_400")
        stub(http(.get, uri: url), json(body, status: 400))

        do {
            _ = try await sut.fetchProducts(value: "foo.search")
        } catch {
            if let error = error as? APIError {
                XCTAssertEqual(error, APIError.defaultError)
            } else {
                XCTFail("error is not an ApiError")
            }
        }
    }

    func testGetFetchProductDetailSuccess() async {
        let url = String(format: sut.network.url(for: .detail), "foo.id")
        let body = readJSON(fileName: "GET_FetchProductDetail_200")
        stub(http(.get, uri: url), json(body, status: 200))

        do {
            let response = try await sut.fetchProductDetail(id: "foo.id")

            let result = response
            XCTAssertEqual(result.text, "Graba videos 4K.")
        } catch {
            XCTFail("This line shouldn't be reached")
            return
        }
    }

    func testGetFetchProductDetailFailure() async {
        let url = String(format: sut.network.url(for: .detail), "foo.id")
        let body = readJSON(fileName: "GET_FetchProductDetail_400")
        stub(http(.get, uri: url), json(body, status: 400))

        do {
            _ = try await sut.fetchProductDetail(id: "foo.id")
        } catch {
            if let error = error as? APIError {
                XCTAssertEqual(error, APIError.defaultError)
            } else {
                XCTFail("error is not an ApiError")
            }
        }
    }
}
