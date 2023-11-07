@testable import ProductFinder
import SnapshotTesting
import XCTest

class ImageCellSnapshotTests: XCTestCase {
    // MARK: - Private Properties

    private var sut: ImageCell!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = ImageCell()
        sut.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testImageCell() {
        let viewData = ImageCellViewData(
            thumbnail: "http://http2.mlstatic.com/D_621305-MLA46153276312_052021-I.jpg",
            placeholderImage: ProductFinderImages.Icons.placeholderImage
        )

        sut.setup(viewData: viewData)
        sut.backgroundColor = .white
        assertSnapshot(of: sut, as: .image)
    }
}
