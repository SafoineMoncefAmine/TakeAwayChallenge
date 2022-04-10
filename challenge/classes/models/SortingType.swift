import Foundation

enum SortingType: String, CaseIterable {
    case openingStatus = "opening status"
    case bestMatch = "best match"
    case newest = "newest"
    case ratingAverage = "rating average"
    case distance = "distance"
    case popularity = "popularity"
    case averageProductPrice = "average price"
    case deliveryCosts = "delivery costs"
    case minCost = "min cost"
}
