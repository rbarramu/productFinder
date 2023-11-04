import UIKit

final class ListProductsViewController: UIViewController {
    // MARK: - Private Properties

    private let tableView = UITableView(frame: .zero)
    private var dataSource: ListProductsDataSource?
    // swiftlint:disable:next weak_delegate
    private var delegate: ListProductsDelegate?

    // MARK: - Public Properties

    var viewModel: SearchItemViewModel?
    var searchValue: String?
    var activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Initialization

    convenience init(dataSource: ListProductsDataSource, delegate: ListProductsDelegate) {
        self.init()
        self.dataSource = dataSource
        self.delegate = delegate
        dataSource.viewController = self
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
            title: String(format: ListProductsConstants.Texts.title, searchValue ?? Constants.empty),
            preferredLargeTitle: true
        )
        tableView.reloadData()
    }

    private func prepareTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.backgroundColor = Theme.current.primaryLight
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ListProductsConstants.Insets.estimatedRowHeight
        tableView.isScrollEnabled = true
        tableView.contentInset = ListProductsConstants.Insets.tableViewInsets
        view.addAutoLayout(subview: tableView)
        Layout.pin(view: tableView, to: view)
    }

    private func registerCells() {
        let productCellIdentifier = String(describing: ProductCell.self)
        tableView.register(ProductCell.self, forCellReuseIdentifier: productCellIdentifier)
    }
}

extension ListProductsViewController: ListProductsViewProtocol {
    func showError(type _: APIError) {}

    func goToSelectedProduct(viewModel _: SearchItemViewModel) {}

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
