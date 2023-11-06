import UIKit

final class ErrorView: UIView {
    // MARK: - Private Properties

    private let containerView = UIView(frame: .zero)
    private let containerStackView = UIStackView(frame: .zero)
    private let labelStackView = UIStackView(frame: .zero)
    private let stackView = UIStackView(frame: .zero)
    private let iconImageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let messageLabel = UILabel(frame: .zero)
    private let button = UIButton(frame: .zero)

    // MARK: - Public Properties

    weak var delegate: ErrorViewDelegate?

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func update(axis: NSLayoutConstraint.Axis) {
        containerStackView.axis = axis
    }

    func setup(type: APIError) {
        switch type {
        case .noResult:
            iconImageView.image = ErrorTypeConstants.NoResultError.icon
            titleLabel.text = ErrorTypeConstants.NoResultError.title
            messageLabel.text = ErrorTypeConstants.NoResultError.message
        case .connectionError:
            iconImageView.image = ErrorTypeConstants.ConnectionError.icon
            titleLabel.text = ErrorTypeConstants.ConnectionError.title
            messageLabel.text = ErrorTypeConstants.ConnectionError.message
        default:
            iconImageView.image = ErrorTypeConstants.GenericError.icon
            titleLabel.text = ErrorTypeConstants.GenericError.title
            messageLabel.text = ErrorTypeConstants.GenericError.message
        }
        prepare()
    }

    // MARK: - Private Methods

    private func prepare() {
        prepareContainerView()
        prepareContainerStack()
        prepareIconImageView()
        prepareLabelStack()
        prepareLabels()
        prepareStack()
        prepareButton()
    }

    private func prepareContainerView() {
        backgroundColor = .white
        if containerView.superview == nil {
            addAutoLayout(subview: containerView)
            Layout.pin(
                view: containerView,
                to: self,
                insets: ErrorViewConstants.ContainerView.insets
            )
        }
    }

    private func prepareContainerStack() {
        containerStackView.addArrangedSubview(iconImageView)
        containerStackView.addArrangedSubview(stackView)
        containerView.addAutoLayout(subview: containerStackView)

        containerStackView.backgroundColor = .clear
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        containerStackView.distribution = .fill
        containerStackView.spacing = ErrorViewConstants.ContainerStackView.spacing

        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: ErrorViewConstants.ContainerStackView.anchorInsets
            ),
            containerStackView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -ErrorViewConstants.ContainerStackView.anchorInsets
            ),
            containerStackView.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: ErrorViewConstants.ContainerStackView.topAnchorInset
            ),
        ])
    }

    private func prepareIconImageView() {
        iconImageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: ErrorViewConstants.Image.anchorInset),
            iconImageView.widthAnchor.constraint(equalToConstant: ErrorViewConstants.Image.anchorInset),
        ])
    }

    private func prepareLabelStack() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(messageLabel)

        labelStackView.backgroundColor = .clear
        labelStackView.axis = .vertical
        labelStackView.alignment = .center
        labelStackView.distribution = .fill
        labelStackView.spacing = ErrorViewConstants.LabelStackView.spacing
    }

    private func prepareLabels() {
        titleLabel.font = UIFont.systemFont(ofSize: ErrorViewConstants.Title.fontSize, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = .zero
        titleLabel.textAlignment = .center

        messageLabel.font = UIFont.systemFont(ofSize: ErrorViewConstants.Message.fontSize, weight: .regular)
        messageLabel.textColor = .black
        messageLabel.numberOfLines = .zero
        messageLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: ErrorViewConstants.Title.widthAnchorInset),
            messageLabel.widthAnchor.constraint(equalToConstant: ErrorViewConstants.Message.widthAnchorInset),
        ])
    }

    private func prepareStack() {
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(button)

        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = ErrorViewConstants.StackView.spacing
    }

    private func prepareButton() {
        button.backgroundColor = .clear
        button.layer.cornerRadius = ErrorViewConstants.Button.cornerRadius
        button.backgroundColor = Theme.current.primaryBackground
        button.setTitle(ErrorViewConstants.Button.title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: ErrorViewConstants.Button.heightAnchor),
            button.widthAnchor.constraint(equalToConstant: ErrorViewConstants.Button.widthAnchor),
        ])
    }

    // MARK: - Action

    @objc
    private func didTapButton(sender _: UIButton) {
        delegate?.didTap()
    }
}
