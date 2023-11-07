import Foundation

class AccessibilityUtils {
    class func formatCLPSymbolToChileanCurrency(text: String) -> String {
        let editedText = text.replacingOccurrences(of: Constants.clpSymbol, with: Constants.empty)
        let formatterText = String(format: "%@ pesos", editedText)
        return formatterText
    }

    class func formatterForAccessibility(text: String) -> String {
        var formatterText = text

        if text.contains(Constants.clpSymbol) {
            formatterText = formatCLPSymbolToChileanCurrency(text: text)
        }

        return formatterText
    }
}
