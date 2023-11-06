import Foundation
@testable import ProductFinder

extension ItemDescription {
    static func mocked(fileName: String = "GET_FetchProductDetail_200") throws -> ItemDescription {
        try JSONDecoder().decode(ItemDescription.self, from: TestCase().readJSONData(fileName: fileName))
    }
}
