@testable import ProductFinder
import SnapshotTesting
import XCTest

class ProductCellSnapshotTests: XCTestCase {
    // MARK: - Private Properties

    private var sut: ProductCell!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = ProductCell()
        sut.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testProductCell() {
        let viewData = ProductCellViewData(
            title: "Apple iPhone 11 (64 Gb) - Blanco",
            price: 1_229_990,
            originalPrice: 2_229_990,
            thumbnail: "http://http2.mlstatic.com/D_878826-MLA71783168396_092023-I.jpg",
            placeholderImage: ProductFinderImages.Icons.placeholderImage,
            acceptsMercadopago: true
        )

        sut.setup(viewData: viewData)
        sut.backgroundColor = .white
        assertSnapshot(of: sut, as: .image)
    }

    func testProductCellWithNilOriginalPrice() {
        let viewData = ProductCellViewData(
            title: "Apple iPhone 11 (64 Gb) - Blanco",
            price: 1_229_990,
            originalPrice: nil,
            thumbnail: "http://http2.mlstatic.com/D_878826-MLA71783168396_092023-I.jpg",
            placeholderImage: ProductFinderImages.Icons.placeholderImage,
            acceptsMercadopago: true
        )

        sut.setup(viewData: viewData)
        sut.backgroundColor = .white
        assertSnapshot(of: sut, as: .image)
    }
}
