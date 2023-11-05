import Kingfisher
import UIKit

class ProductCell: UITableViewCell {
    // MARK: - Private Properties

    private let containerView = UIView(frame: .zero)
    private let stackContainer = UIStackView(frame: .zero)
    private let stackViewDetail = UIStackView(frame: .zero)
    private let imageProductView = UIImageView(frame: .zero)
    private let titleLabel = UILabel()
    private let originalPriceLabel = UILabel()
    private let priceLabel = UILabel()
    private let badge = UILabel()

    private var viewData: ProductCellViewData?

    // MARK: - Initialization

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageProductView.image = nil
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }

    // MARK: - Public Method

    func setup(viewData: ProductCellViewData) {
        self.viewData = viewData
        prepare()
    }

    // MARK: - Private Methods

    private func prepare() {
        prepareContainer()
        prepareStackContainer()
        prepareImage()
        prepareStackViewDetail()
    }

    private func prepareContainer() {
        backgroundColor = .clear
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = ProductCellConstants.Container.cornerRadius

        if containerView.superview == nil {
            contentView.addAutoLayout(subview: containerView)
            Layout.pin(
                view: containerView,
                to: contentView,
                insets: ProductCellConstants.Container.containerViewInset
            )
        }
    }

    private func prepareStackContainer() {
        stackContainer.alignment = .center
        stackContainer.axis = .horizontal
        stackContainer.distribution = .fill
        stackContainer.spacing = ProductCellConstants.StackContainer.stackContainerSpace

        if stackContainer.superview == nil {
            containerView.addAutoLayout(subview: stackContainer)
            Layout.pin(
                view: stackContainer,
                to: containerView,
                insets: ProductCellConstants.StackContainer.stackContainerInset
            )
        }
    }

    private func prepareImage() {
        guard let viewData, let url = URL(string: viewData.thumbnail) else { fatalError("Unable to load product") }

        stackContainer.addArrangedSubview(imageProductView)

        NSLayoutConstraint.activate([
            imageProductView.heightAnchor.constraint(equalToConstant: ProductCellConstants.Image.anchorImageProductView),
            imageProductView.widthAnchor.constraint(equalToConstant: ProductCellConstants.Image.anchorImageProductView),
        ])

        imageProductView.contentMode = .scaleAspectFit

        imageProductView.kf.setImage(
            with: url,
            placeholder: viewData.placeholderImage,
            options: [.transition(.fade(1))]
        )
    }

    private func prepareStackViewDetail() {
        guard let viewData else { fatalError("Unable to load product") }

        stackContainer.addArrangedSubview(stackViewDetail)
        stackViewDetail.addArrangedSubview(badge)
        stackViewDetail.addArrangedSubview(titleLabel)
        stackViewDetail.addArrangedSubview(originalPriceLabel)
        stackViewDetail.addArrangedSubview(priceLabel)

        stackViewDetail.alignment = .leading
        stackViewDetail.axis = .vertical
        stackViewDetail.distribution = .fill
        stackViewDetail.spacing = ProductCellConstants.StackViewDetail.stackSpacing

        badge.text = ProductCellConstants.Text.badgeText
        badge.textColor = .white
        badge.font = UIFont.systemFont(ofSize: ProductCellConstants.StackViewDetail.badgeFontSize, weight: .semibold)
        badge.backgroundColor = Theme.current.blueLight
        badge.isHidden = !viewData.acceptsMercadopago

        titleLabel.text = viewData.title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(
            ofSize: ProductCellConstants.StackViewDetail.titleFontSize,
            weight: .regular
        )
        titleLabel.numberOfLines = .zero

        if let originalPrice = viewData.originalPrice {
            let attributedText = NSAttributedString(
                string: Formatter.format(float: originalPrice, style: .amountCLP),
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )

            originalPriceLabel.attributedText = attributedText
            originalPriceLabel.textColor = .black
            originalPriceLabel.font = UIFont.systemFont(
                ofSize: ProductCellConstants.StackViewDetail.originalPriceFontSize,
                weight: .regular
            )
        }

        priceLabel.text = Formatter.format(float: viewData.price, style: .amountCLP)
        priceLabel.textColor = .black
        priceLabel.font = UIFont.systemFont(
            ofSize: ProductCellConstants.StackViewDetail.priceFontSize,
            weight: .bold
        )
    }
}
