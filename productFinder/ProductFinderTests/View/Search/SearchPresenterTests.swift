@testable import ProductFinder
import XCTest

class SearchPresenterTests: TestCase {
    var sut: SearchPresenter!
    var view: SearchViewControllerMock!
    var repository: ProductFinderRepositoryMock!

    override func setUp() {
        super.setUp()

        repository = ProductFinderRepositoryMock()
        sut = SearchPresenter(
            fetchProductsUseCase: FetchProductsUseCase(repository: repository),
            searchItemMapper: FetchProductsMapper()
        )

        view = SearchViewControllerMock()
        sut.attach(view: view)
    }

    override func tearDown() {
        sut = nil
        view = nil
        repository = nil
        super.tearDown()
    }

    func testFetchProductsSuccess() async {
        await sut.fetchProduct(value: "foo.value")
        XCTAssertTrue(view.goToItemCalled)
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertFalse(view.showErrorCalled)
    }

    func testFetchProductsFailure() async {
        repository.success = false
        await sut.fetchProduct(value: "foo.value")
        XCTAssertTrue(view.showErrorCalled)
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertFalse(view.goToItemCalled)
    }
}
