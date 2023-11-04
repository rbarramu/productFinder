import UIKit

class ProductCell: UITableViewCell {
    // MARK: - Private Properties

    private let containerView = UIView()
    private let stackContainer = UIStackView()
    private let stackViewDetail = UIStackView()
    private let imageProductView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()

    private var viewData: ProductCellViewData?

    // MARK: - Initialization

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addAutoLayout(subview: containerView)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = ProductCellConstants.Insets.cornerRadius

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: ProductCellConstants.Insets.ContainerView.leading
            ),
            containerView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: ProductCellConstants.Insets.ContainerView.trailing
            ),
            containerView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: ProductCellConstants.Insets.ContainerView.top
            ),
            containerView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: ProductCellConstants.Insets.ContainerView.bottom
            ),
        ])
    }

    func prepareStackContainer() {
        containerView.addAutoLayout(subview: stackContainer)
        stackContainer.alignment = .leading
        stackContainer.axis = .horizontal
        stackContainer.spacing = ProductCellConstants.Insets.stackContainerSpace

        NSLayoutConstraint.activate([
            stackContainer.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: ProductCellConstants.Insets.StackContainer.leading
            ),
            stackContainer.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: ProductCellConstants.Insets.StackContainer.trailing
            ),
            stackContainer.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: ProductCellConstants.Insets.StackContainer.top
            ),
            stackContainer.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: ProductCellConstants.Insets.StackContainer.bottom
            ),
        ])
    }

    // MARK: - Public Methods

    private func prepareImage() {
        stackContainer.addArrangedSubview(imageProductView)

        NSLayoutConstraint.activate([
            imageProductView.heightAnchor.constraint(equalToConstant: 200),
            imageProductView.widthAnchor.constraint(equalToConstant: 200),
        ])

        imageProductView.contentMode = .scaleAspectFit
        imageProductView.image = 
    }

    func prepareStackViewDetail() {
        stackContainer.addArrangedSubview(stackViewDetail)
        stackViewDetail.alignment = .leading
        stackViewDetail.axis = .vertical
        stackViewDetail.distribution = .fillEqually
        stackViewDetail.addArrangedSubview(titleLabel)
        stackViewDetail.addArrangedSubview(priceLabel)

        titleLabel.text = viewData?.title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = .zero

        priceLabel.text = viewData?.price
        priceLabel.textColor = .black
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)

//        NSLayoutConstraint.activate([
//            stackViewContent.heightAnchor.constrain(to: InfoPlanCellConstants.Anchors.StackViewContent.height)
//        ])
    }
}
