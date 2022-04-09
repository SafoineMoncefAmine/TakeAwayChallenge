import Foundation

struct Restaurant {
    let name: String
    let status: Status
    let sortingValues: SortingValues
}

struct SortingValues {
    let bestMatch, newest: Int
    let ratingAverage: Double
    let distance, popularity, averageProductPrice, deliveryCosts: Int
    let minCost: Int
}

enum Status: String {
    case closed = "closed"
    case orderAhead = "order ahead"
    case open = "open"
}
