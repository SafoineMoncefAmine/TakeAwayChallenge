import Foundation

class RestaurantListViewModel {

    var loadDataHandler: () -> Void = { }
    private(set) var restaurants: [Restaurant] = []
    private(set) var cellModels: [RestaurantCellViewModelProtocol] = []
    private let service: RestaurantsServiceProtocol

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
            status: $0.status.rawValue,
            sortingTitle: $0.sortingValues.minCost.description,
            sortingValue: $0.sortingValues.minCost.description)
        })
    }
    func statusTitle(status: Status) -> String {
        switch status {
        case .closed: return "closed"
        case .open: return "open"
        case .orderAhead: return "order ahead"
        }
    }
}
