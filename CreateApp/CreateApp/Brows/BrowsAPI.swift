
import Foundation

struct CategoriesAPI: Decodable {
    let status: Int
    let response: ArrayCategories?
}

struct ArrayCategories: Decodable {
    let categories: [Categories]?
    
}
struct Categories: Decodable {
    let id: Int
    let name: String?
    let slug: String?
}
