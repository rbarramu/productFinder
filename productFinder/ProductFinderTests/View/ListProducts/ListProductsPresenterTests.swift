@testable import ProductFinder
import XCTest

class ListProductsPresenterTests: TestCase {
    var sut: ListProductsPresenter!
    var view: ListProductsViewControllerMock!
    var repository: ProductFinderRepositoryMock!

    override func setUp() {
        super.setUp()

        repository = ProductFinderRepositoryMock()
        sut = ListProductsPresenter(
            fetchProductDetailUseCase: FetchProductDetailUseCase(repository: repository),
            itemDescriptionMapper: FetchProductDetailMapper()
        )

        view = ListProductsViewControllerMock()
        sut.attach(view: view)
    }

    override func tearDown() {
        sut = nil
        view = nil
        repository = nil
        super.tearDown()
    }

    func testFetchProductDetailSuccess() async {
        await sut.fetchDetailProduct(id: "foo.id")
        XCTAssertTrue(view.goToSelectedProductCalled)
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertFalse(view.showErrorCalled)
    }

    func testFetchProductDetailFailure() async {
        repository.success = false
        await sut.fetchDetailProduct(id: "foo.id")
        XCTAssertTrue(view.showErrorCalled)
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertFalse(view.goToSelectedProductCalled)
    }
}
