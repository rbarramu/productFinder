@testable import ProductFinder
import XCTest

class LayoutTests: TestCase {
    var view: UIView!
    var superview: UIView!

    override func setUp() {
        super.setUp()
        view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        superview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    override func tearDown() {
        for subview in superview.subviews.reversed() {
            subview.removeFromSuperview()
        }
        view = nil
        superview = nil
        super.tearDown()
    }

    func testPinView() {
        superview.addAutoLayout(subview: view)
        Layout.pin(view: view, to: superview)
    }
}
