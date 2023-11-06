@testable import ProductFinder
import XCTest

class FormatterTests: TestCase {
    func testFormatter_AmountCLP() {
        let expected = "$1.234"
        let formatted = Formatter.format(float: 1234.0, style: .amountCLP)
        XCTAssertEqual(expected, formatted)
    }

    func testFormatter_AmountCLP_Negative() {
        let expected = "$-1.234"
        let formatted = Formatter.format(float: -1234.0, style: .amountCLP)
        XCTAssertEqual(expected, formatted)
    }
}
