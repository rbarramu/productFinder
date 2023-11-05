import Foundation

final class FetchProductsMapper: Mapper<SearchItemViewModel, SearchItem> {
    override func reverseMap(value: SearchItem) -> SearchItemViewModel {
        var products: [ItemViewModel] = []
        for product in value.results {
            let productViewModel = ItemViewModel(
                id: product.id,
                title: product.title,
                price: product.price,
                thumbnail: product.thumbnail,
                originalPrice: product.originalPrice,
                acceptsMercadopago: product.acceptsMercadopago
            )
            products.append(productViewModel)
        }

        return SearchItemViewModel(results: products)
    }
}
