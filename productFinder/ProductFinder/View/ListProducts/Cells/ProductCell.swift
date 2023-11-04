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
        containerView.layer.cornerRadius = ProductCellConstants.cornerRadius

        if containerView.superview == nil {
            contentView.addAutoLayout(subview: containerView)
            Layout.pin(
                view: containerView,
                to: contentView,
                insets: ProductCellConstants.containerViewInset
            )
        }
    }

    func prepareStackContainer() {
        containerView.addAutoLayout(subview: stackContainer)
        stackContainer.alignment = .center
        stackContainer.axis = .horizontal
        stackContainer.distribution = .fill
        stackContainer.spacing = ProductCellConstants.stackContainerSpace

        NSLayoutConstraint.activate([
            stackContainer.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: ProductCellConstants.anchorStackContainer
            ),
            stackContainer.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -ProductCellConstants.anchorStackContainer
            ),
            stackContainer.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: ProductCellConstants.anchorStackContainer
            ),
            stackContainer.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -ProductCellConstants.anchorStackContainer
            ),
        ])
    }

    // MARK: - Public Methods

    private func prepareImage() {
        guard let viewData, let url = URL(string: viewData.thumbnail) else { fatalError("Unable to load product") }

        stackContainer.addArrangedSubview(imageProductView)

        NSLayoutConstraint.activate([
            imageProductView.heightAnchor.constraint(equalToConstant: ProductCellConstants.anchorImageProductView),
            imageProductView.widthAnchor.constraint(equalToConstant: ProductCellConstants.anchorImageProductView),
        ])

        imageProductView.contentMode = .scaleAspectFit

        imageProductView.kf.setImage(
            with: url,
            placeholder: viewData.placeholderImage,
            options: [.transition(.fade(1))]
        )
    }

    func prepareStackViewDetail() {
        guard let viewData else { fatalError("Unable to load product") }

        stackContainer.addArrangedSubview(stackViewDetail)
        stackViewDetail.addArrangedSubview(badge)
        stackViewDetail.addArrangedSubview(titleLabel)
        stackViewDetail.addArrangedSubview(originalPriceLabel)
        stackViewDetail.addArrangedSubview(priceLabel)

        stackViewDetail.alignment = .leading
        stackViewDetail.axis = .vertical
        stackViewDetail.distribution = .fill
        stackViewDetail.spacing = ProductCellConstants.stackSpacing

        badge.text = ProductCellConstants.Text.badgeText
        badge.textColor = .white
        badge.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        badge.backgroundColor = Theme.current.blueLight
        badge.isHidden = !viewData.acceptsMercadopago

        titleLabel.text = viewData.title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        titleLabel.numberOfLines = .zero

        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "es_CL")
        currencyFormatter.currencyCode = viewData.currencyId

        if let originalPrice = viewData.originalPrice {
            let attributedText = NSAttributedString(
                string: currencyFormatter.string(
                    from: NSNumber(value: originalPrice)) ?? Constants.empty,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )

            originalPriceLabel.attributedText = attributedText
            originalPriceLabel.textColor = .black
            originalPriceLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }

        priceLabel.text = currencyFormatter.string(from: NSNumber(value: viewData.price))
        priceLabel.textColor = .black
        priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
