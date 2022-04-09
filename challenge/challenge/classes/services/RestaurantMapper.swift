import Foundation

class RestaurantMapper {

    enum Error: Swift.Error {
        case invalidData
    }

    private struct Root: Codable {
        let restaurants: [RemoteRestaurant]
        var mappedRestaurants: [Restaurant] {
            restaurants.map({
                let status: Status
                switch $0.status {
                case .statusOpen: status = .open
                case .closed: status = .closed
                case .orderAhead: status = .orderAhead
                }
                return Restaurant(
                    name: $0.name,
                    status: status,
                    sortingValues: SortingValues(
                        bestMatch: $0.sortingValues.bestMatch,
                        newest: $0.sortingValues.newest,
                        ratingAverage: $0.sortingValues.ratingAverage,
                        distance: $0.sortingValues.distance,
                        popularity: $0.sortingValues.popularity,
                        averageProductPrice: $0.sortingValues.averageProductPrice,
                        deliveryCosts: $0.sortingValues.deliveryCosts,
                        minCost: $0.sortingValues.minCost)
                )
            })
        }
    }

    private struct RemoteRestaurant: Codable {
        let name: String
        let status: RemoteStatus
        let sortingValues: RemoteSortingValues
    }

    private struct RemoteSortingValues: Codable {
        let bestMatch, newest: Int
        let ratingAverage: Double
        let distance, popularity, averageProductPrice, deliveryCosts: Int
        let minCost: Int
    }

    private enum RemoteStatus: String, Codable {
        case closed = "closed"
        case orderAhead = "order ahead"
        case statusOpen = "open"
    }

    static func map(_ data: Data) throws -> [Restaurant] {
        guard let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.mappedRestaurants
    }
}
