@testable import ProductFinder
import XCTest

class ViewAutoLayoutTests: TestCase {
    var sut: UIView!

    override func setUp() {
        super.setUp()
        sut = UIView(frame: .zero)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testAddAutoLayoutSubview() {
        let view = UIView(frame: .zero)
        sut.addAutoLayout(subview: view)
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }
}
