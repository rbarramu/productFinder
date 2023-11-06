@testable import ProductFinder
import SnapshotTesting
import XCTest

class ErrorViewSnapshotTests: XCTestCase {
    // MARK: - Private Properties

    private var sut: ErrorView!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = ErrorView()
        sut.frame = CGRect(x: 0, y: 0, width: 400, height: 600)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testErrorViewDefaultError() {
        sut.setup(type: .defaultError)
        sut.backgroundColor = .white
        assertSnapshot(of: sut, as: .image)
    }

    func testErrorViewConnectionError() {
        sut.setup(type: .connectionError)
        sut.backgroundColor = .white
        assertSnapshot(of: sut, as: .image)
    }

    func testErrorViewNoResult() {
        sut.setup(type: .noResult)
        sut.backgroundColor = .white
        assertSnapshot(of: sut, as: .image)
    }
}
