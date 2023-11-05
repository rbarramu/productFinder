import Foundation
import UIKit

final class Formatter {
    class func format(float: Float, style: FormatStyle) -> String {
        switch style {
        case .amountCLP:
            return formatToCLP(amount: float)
        }
    }

    private class func formatToCLP(amount: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: Constants.Locale.chile)
        formatter.currencyCode = Constants.Currency.chileanCurrency

        let value = formatter.string(from: NSNumber(value: amount)) ?? Constants.empty

        return value
    }
}
