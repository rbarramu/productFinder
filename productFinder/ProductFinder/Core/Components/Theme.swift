import UIKit

struct Theme {
    let primaryBackground: UIColor
    let primaryLight: UIColor
    let blueLight: UIColor

    static var current = Theme.originalTheme

    static let originalTheme = Theme(
        primaryBackground: Colors.yellow,
        primaryLight: Colors.lightGray,
        blueLight: Colors.blueLight
    )
}

private enum Colors {
    static let yellow = #colorLiteral(red: 0.9996184707, green: 0.9006812572, blue: 0.0002467182348, alpha: 1)
    static let lightGray = #colorLiteral(red: 0.9293302894, green: 0.929463923, blue: 0.9293010831, alpha: 1)
    static let blueLight = #colorLiteral(red: 0.002093822928, green: 0.6185739636, blue: 0.8889719844, alpha: 1)
}
