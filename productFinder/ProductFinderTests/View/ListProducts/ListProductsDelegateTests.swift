@testable import ProductFinder
import XCTest

class ListProductsDelegateTests: TestCase {
    var sut: ListProductsDelegate!
    var view: ListProductsViewControllerMock!

    override func setUp() {
        super.setUp()

        sut = ListProductsDelegate()
        view = ListProductsViewControllerMock()
        view.viewModel = SearchItemViewModel(
            results: [ItemViewModel(
                id: "foo.id",
                title: "foo.title",
                price: 0.0,
                thumbnail: "foo.thumbnail",
                originalPrice: 0.0,
                acceptsMercadopago: true
            )]
        )
    }

    override func tearDown() {
        sut = nil
        view = nil
        super.tearDown()
    }

    func testHeightForRowAt() {
        guard let viewModel = view.viewModel else { return }

        for (index, _) in viewModel.results.enumerated() {
            let height = sut.tableView(UITableView(), heightForRowAt: IndexPath(row: index, section: 0))
            XCTAssertEqual(height, UITableView.automaticDimension)
        }
    }
}
