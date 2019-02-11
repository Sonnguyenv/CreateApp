
import Foundation
struct ResponseSample: Decodable {
    let status: Int
    let response: Response?
}
struct Response: Decodable {
    let token: String?
}
