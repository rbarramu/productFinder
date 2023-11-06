@testable import ProductFinder
import SnapshotTesting
import XCTest

class TitleCellSnapshotTests: XCTestCase {
    // MARK: - Private Properties

    private var sut: TitleCell!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = TitleCell()
        sut.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testTitleCell() {
        let viewData = TitleCellViewData(title: "title", isStrikethrough: false)
        let viewStyle = TitleCellViewStyle()

        sut.setup(viewData: viewData, viewStyle: viewStyle)
        sut.backgroundColor = .white
        assertSnapshot(of: sut, as: .image)
    }
}
