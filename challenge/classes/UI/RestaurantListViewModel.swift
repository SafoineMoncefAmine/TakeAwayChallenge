import Foundation

class RestaurantListViewModel {

    var loadDataHandler: () -> Void = { }
    private(set) var restaurants: [Restaurant] = []
    private(set) var cellModels: [RestaurantCellViewModelProtocol] = []
    private let service: RestaurantsServiceProtocol

    enum SortingType {
        case bestMatch
        case newest
        case ratingAverage
        case distance
        case popularity
        case averageProductPrice
        case deliveryCosts
        case minCost
    }

    init(service: RestaurantsServiceProtocol) {
        self.service = service
    }

    func loadRestaurants() {
        service.loadRestaurants { [weak self] restaurants in
            self?.restaurants = restaurants
            self?.generateCellsViewModels()
            self?.loadDataHandler()
        }
    }

    private func generateCellsViewModels() {
        cellModels = restaurants.map({ RestaurantCellViewModel(
            name: $0.name,
            status: statusTitle(status: $0.status),
            sortingTitle: $0.sortingValues.minCost.description,
            sortingValue: $0.sortingValues.minCost.description)
        })
    }

    private func statusTitle(status: Status) -> String {
        switch status {
        case .closed: return "closed"
        case .open: return "open"
        case .orderAhead: return "order ahead"
        }
    }
}
