import Foundation

struct APIItemDescription: Decodable {
    let id: String
    let text: String

    private enum CodingKeys: String, CodingKey {
        case id
        case text = "plain_text"
    }
}
