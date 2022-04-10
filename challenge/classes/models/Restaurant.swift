import Foundation
struct Restaurant {
    let name: String
    let status: Status
    let sortingValues: [SortingType: Double]
}

enum Status: String {
    case closed = "closed"
    case orderAhead = "order ahead"
    case open = "open"
}
