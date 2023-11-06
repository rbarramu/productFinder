@testable import ProductFinder
import XCTest

class ListProductsDataSourceTests: TestCase {
    var sut: ListProductsDataSource!
    var view: ListProductsViewController!

    override func setUp() {
        super.setUp()
        let repository = ProductFinderRepositoryMock()
        sut = ListProductsDataSource()
        view = ListProductsViewController(
            dataSource: sut,
            delegate: ListProductsDelegate(),
            presenter: ListProductsPresenter(
                fetchProductDetailUseCase: FetchProductDetailUseCase(repository: repository),
                itemDescriptionMapper: FetchProductDetailMapper()
            )
        )
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
        let productCellIdentifier = String(describing: ProductCell.self)
        view.tableView.register(ProductCell.self, forCellReuseIdentifier: productCellIdentifier)
    }

    override func tearDown() {
        sut = nil
        view = nil
        super.tearDown()
    }

    func testCellForRow() {
        guard let viewModel = view.viewModel else { return }

        for (index, _) in viewModel.results.enumerated() {
            let cell: ProductCell? = cell(at: IndexPath(row: index, section: 0))
            XCTAssertNotNil(cell)
        }
    }

    private func cell<T>(at indexPath: IndexPath) -> T? {
        guard let cell = sut.tableView(view.tableView, cellForRowAt: indexPath) as? T else {
            XCTFail("Could not load cell of class \(T.self) at row \(indexPath.row), section \(indexPath.section)")
            return nil
        }

        return cell
    }
}
