protocol SearchPresenterProtocol: AnyObject {
    func attach(view: SearchViewProtocol)
    func fetchProduct(value: String) async
}
