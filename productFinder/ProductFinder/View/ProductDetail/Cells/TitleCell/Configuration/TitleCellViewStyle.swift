import UIKit

struct TitleCellViewStyle {
    let titleFont: UIFont
    let titleColor: UIColor
    let titleInsets: UIEdgeInsets

    init(
        titleFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .regular),
        titleColor: UIColor = .black,
        titleInsets: UIEdgeInsets = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
    ) {
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.titleInsets = titleInsets
    }
}
