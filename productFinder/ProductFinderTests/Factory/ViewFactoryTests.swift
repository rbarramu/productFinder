@testable import ProductFinder
import XCTest

class ViewFactoryTests: TestCase {
    var sut: ViewFactory!

    override func setUp() {
        super.setUp()
        sut = ViewFactory(serviceLocator: ProductFinderServiceLocator())
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewFactoryType() {
        let types: [ViewFactoryType] = [
            .splash,
            .search,
            .listProducts,
            .productDetail,
        ]

        for type in types {
            let viewController = sut.viewController(type: type)
            switch type {
            case .splash:
                XCTAssertTrue(viewController is SplashViewController)
            case .search:
                XCTAssertTrue(viewController is SearchViewController)
            case .listProducts:
                XCTAssertTrue(viewController is ListProductsViewController)
            case .productDetail:
                XCTAssertTrue(viewController is ProductDetailViewController)
            }
        }
    }
}
