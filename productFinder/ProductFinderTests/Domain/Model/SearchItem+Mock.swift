import Foundation
@testable import ProductFinder

extension SearchItem {
    static func mocked(fileName: String = "GET_FetchProducts_200") throws -> SearchItem {
        try JSONDecoder().decode(SearchItem.self, from: TestCase().readJSONData(fileName: fileName))
    }
}
