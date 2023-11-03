import Foundation

final class FetchProductsMapper: Mapper<SearchItemViewModel, SearchItem> {
    override func reverseMap(value: SearchItem) -> SearchItemViewModel {
        var products: [ItemListViewModel] = []
        for product in value.results {
            let productViewModel = ItemListViewModel(
                id: product.id,
                title: product.title,
                price: product.price,
                thumbnail: product.thumbnail
            )
            products.append(productViewModel)
        }

        return SearchItemViewModel(results: products)
    }
}
