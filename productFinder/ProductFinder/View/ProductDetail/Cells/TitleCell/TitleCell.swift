import UIKit

final class TitleCell: UITableViewCell {
    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private var viewData: TitleCellViewData?
    private var viewStyle: TitleCellViewStyle?

    // MARK: - Initialization

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }

    func setup(
        viewData: TitleCellViewData,
        viewStyle: TitleCellViewStyle = TitleCellViewStyle()
    ) {
        self.viewData = viewData
        self.viewStyle = viewStyle
        prepareLabel()
    }

    // MARK: - Private Methods

    private func prepareLabel() {
        guard let viewData, let viewStyle else { fatalError("Unable to load text") }

        backgroundColor = .clear

        if titleLabel.superview == nil {
            contentView.addAutoLayout(subview: titleLabel)
            Layout.pin(
                view: titleLabel,
                to: contentView,
                insets: viewStyle.titleInsets
            )
        }

        if let isStrikethrough = viewData.isStrikethrough, isStrikethrough {
            let attributedText = NSAttributedString(
                string: viewData.title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            titleLabel.attributedText = attributedText
        } else {
            titleLabel.text = viewData.title
        }

        titleLabel.backgroundColor = .clear
        titleLabel.textColor = viewStyle.titleColor
        titleLabel.numberOfLines = .zero
        titleLabel.textAlignment = .left
        titleLabel.font = viewStyle.titleFont
        titleLabel.sizeToFit()
    }
}