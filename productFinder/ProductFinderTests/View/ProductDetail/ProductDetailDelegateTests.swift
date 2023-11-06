@testable import ProductFinder
import XCTest

class ProductDetailDelegateTests: TestCase {
    var sut: ProductDetailDelegate!
    var view: ListProductsViewControllerMock!

    override func setUp() {
        super.setUp()

        sut = ProductDetailDelegate()
        view = ListProductsViewControllerMock()
    }

    override func tearDown() {
        sut = nil
        view = nil
        super.tearDown()
    }

    func testHeightForRowAt() {
        for (index, _) in ProductDetailCellType.allCases.enumerated() {
            let height = sut.tableView(UITableView(), heightForRowAt: IndexPath(row: index, section: 0))
            XCTAssertEqual(height, UITableView.automaticDimension)
        }
    }
}
