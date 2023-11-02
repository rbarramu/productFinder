import UIKit

struct Theme {
    let primaryBackground: UIColor

    static var current = Theme.originalTheme

    static let originalTheme = Theme(primaryBackground: Colors.yellow)
}

private enum Colors {
    static let yellow = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
}
