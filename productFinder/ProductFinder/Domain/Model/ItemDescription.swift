import Foundation

struct ItemDescription: Decodable {
    let text: String

    private enum CodingKeys: String, CodingKey {
        case text = "plain_text"
    }
}
