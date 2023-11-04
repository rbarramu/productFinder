import Foundation

final class FetchProductDetailMapper: Mapper<ItemDescriptionViewModel, ItemDescription> {
    override func reverseMap(value: ItemDescription) -> ItemDescriptionViewModel {
        ItemDescriptionViewModel(text: value.text)
    }
}
