import UIKit

final class ListProductsViewController: UIViewController {
    // MARK: - Private Properties

    private let tableView = UITableView(frame: .zero)
    private var dataSource: ListProductsDataSource?
    // swiftlint:disable:next weak_delegate
    private var delegate: ListProductsDelegate?
    private var presenter: ListProductsPresenterProtocol?

    // MARK: - Public Properties

    var viewModel: SearchItemViewModel?
    var selectedViewModel: ItemViewModel?
    var searchValue: String?
    var activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Initialization

    convenience init(
        dataSource: ListProductsDataSource,
        delegate: ListProductsDelegate,
        presenter: ListProductsPresenterProtocol
    ) {
        self.init()
        self.dataSource = dataSource
        self.delegate = delegate
        self.presenter = presenter
        dataSource.viewController = self
        delegate.viewController = self
        presenter.attach(view: self)
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

    func routeToDetail(indexPath: IndexPath) {
        guard let selectedItem = viewModel?.results[indexPath.row] else { return }
        selectedViewModel = selectedItem
        Task {
            await presenter?.fetchDetailProduct(id: selectedItem.id)
        }
    }
}

extension ListProductsViewController: ListProductsViewProtocol {
    func showError(type _: APIError) {}

    func goToSelectedProduct(itemDescriptionViewModel: ItemDescriptionViewModel) {
        guard let viewController = ViewFactory(
            serviceLocator: ProductFinderServiceLocator()
        ).viewController(type: .productDetail) as? ProductDetailViewController
        else { return }

        viewController.itemViewModel = selectedViewModel
        viewController.itemDescriptionViewModel = itemDescriptionViewModel
        navigationController?.pushViewController(viewController, animated: true)
    }

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
