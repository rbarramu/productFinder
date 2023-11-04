import Foundation

final class FetchProductsMapper: Mapper<SearchItemViewModel, SearchItem> {
    override func reverseMap(value: SearchItem) -> SearchItemViewModel {
        var products: [ItemListViewModel] = []
        for product in value.results {
            let productViewModel = ItemListViewModel(
                id: product.id,
                title: product.title,
                price: product.price,
                thumbnail: product.thumbnail,
                currencyId: product.currencyId,
                originalPrice: product.originalPrice,
                acceptsMercadopago: product.acceptsMercadopago
            )
            products.append(productViewModel)
        }

        return SearchItemViewModel(results: products)
    }
}
