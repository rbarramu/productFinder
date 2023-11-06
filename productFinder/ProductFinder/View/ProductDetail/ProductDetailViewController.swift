import UIKit

final class ProductDetailViewController: UIViewController {
    // MARK: - Private Properties

    private var dataSource: ProductDetailDataSource?
    // swiftlint:disable:next weak_delegate
    private var delegate: ProductDetailDelegate?

    // MARK: - Public Properties

    let tableView = UITableView(frame: .zero)
    var itemViewModel: ItemViewModel?
    var itemDescriptionViewModel: ItemDescriptionViewModel?
    var activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Initialization

    convenience init(
        dataSource: ProductDetailDataSource,
        delegate: ProductDetailDelegate
    ) {
        self.init()
        self.dataSource = dataSource
        self.delegate = delegate
        dataSource.viewController = self
        delegate.viewController = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        registerCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        configureNavigationBar(
            largeTitleColor: .black,
            backgroundColor: Theme.current.primaryBackground,
            tintColor: .black,
            title: Constants.empty,
            preferredLargeTitle: true
        )
        tableView.reloadData()
    }

    // MARK: - Private Methods

    private func prepareTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.backgroundColor = Theme.current.primaryLight
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ProductDetailConstants.Insets.estimatedRowHeight
        tableView.isScrollEnabled = true
        tableView.contentInset = ProductDetailConstants.Insets.tableViewInsets
        view.addAutoLayout(subview: tableView)
        Layout.pin(view: tableView, to: view)
    }

    private func registerCells() {
        let imageCellIdentifier = String(describing: ImageCell.self)
        let titleCellIdentifier = String(describing: TitleCell.self)
        tableView.register(ImageCell.self, forCellReuseIdentifier: imageCellIdentifier)
        tableView.register(TitleCell.self, forCellReuseIdentifier: titleCellIdentifier)
    }
}

// MARK: - ProductDetailViewProtocol

extension ProductDetailViewController: ProductDetailViewProtocol {
    func showLoading(status: Bool) {
        DispatchQueue.main.async {
            guard status else {
                self.hideActivityIndicator()
                return
            }
            self.showActivityIndicator()
        }
    }
}
