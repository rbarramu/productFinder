import Kingfisher
import UIKit

final class ImageCell: UITableViewCell {
    // MARK: - Private Properties

    private let containerView = UIView(frame: .zero)
    private let imageProductView = UIImageView(frame: .zero)
    private var viewData: ImageCellViewData?

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

    func setup(viewData: ImageCellViewData) {
        self.viewData = viewData
        prepare()
    }

    // MARK: - Private Methods

    private func prepare() {
        prepareContainer()
        prepareImage()
        containerView.accessibilityElementsHidden = true
        imageProductView.accessibilityElementsHidden = true
    }

    private func prepareContainer() {
        containerView.backgroundColor = .white

        if containerView.superview == nil {
            contentView.addAutoLayout(subview: containerView)
            Layout.pin(
                view: containerView,
                to: contentView,
                insets: ImageCellConstants.imageProductViewInset
            )
        }
    }

    private func prepareImage() {
        guard let viewData, let url = URL(string: viewData.thumbnail) else { fatalError("Unable to load product") }

        if imageProductView.superview == nil {
            containerView.addAutoLayout(subview: imageProductView)
            Layout.pin(
                view: imageProductView,
                to: containerView,
                insets: ImageCellConstants.imageProductViewInset
            )
        }

        NSLayoutConstraint.activate([
            imageProductView.heightAnchor.constraint(equalToConstant: ImageCellConstants.anchorImageProductView),
        ])

        imageProductView.contentMode = .scaleAspectFit

        imageProductView.kf.setImage(
            with: url,
            placeholder: viewData.placeholderImage,
            options: [.transition(.fade(1))]
        )
    }
}
