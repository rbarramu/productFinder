protocol ListProductsPresenterProtocol: AnyObject {
    func attach(view: ListProductsViewProtocol)
    func fetchDetailProduct(id: String) async
}
