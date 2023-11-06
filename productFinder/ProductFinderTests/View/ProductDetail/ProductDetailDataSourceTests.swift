@testable import ProductFinder
import XCTest

class ProductDetailDataSourceTests: TestCase {
    var sut: ProductDetailDataSource!
    var view: ProductDetailViewController!

    override func setUp() {
        super.setUp()
        sut = ProductDetailDataSource()
        view = ProductDetailViewController(
            dataSource: sut,
            delegate: ProductDetailDelegate()
        )
        view.itemViewModel = ItemViewModel(
            id: "foo.id",
            title: "foo.title",
            price: 0.0,
            thumbnail: "foo.thumbnail",
            originalPrice: 0.0,
            acceptsMercadopago: true
        )

        view.itemDescriptionViewModel = ItemDescriptionViewModel(text: "foo.text")

        let imageCellIdentifier = String(describing: ImageCell.self)
        let titleCellIdentifier = String(describing: TitleCell.self)
        view.tableView.register(ImageCell.self, forCellReuseIdentifier: imageCellIdentifier)
        view.tableView.register(TitleCell.self, forCellReuseIdentifier: titleCellIdentifier)
    }

    override func tearDown() {
        sut = nil
        view = nil
        super.tearDown()
    }

    func testCellForRow() {
        for (index, cellType) in ProductDetailCellType.allCases.enumerated() {
            switch cellType {
            case .image:
                let cell: ImageCell? = cell(at: IndexPath(row: index, section: 0))
                XCTAssertNotNil(cell)
            case .title, .originalPrice, .price, .descriptionTitle, .description:
                let cell: TitleCell? = cell(at: IndexPath(row: index, section: 0))
                XCTAssertNotNil(cell)
            }
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
