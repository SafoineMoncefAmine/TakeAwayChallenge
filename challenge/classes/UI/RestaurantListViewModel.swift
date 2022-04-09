import Foundation

class RestaurantListViewModel {

    var loadDataHandler: () -> Void = { }
    var sortTypes: [SortingType] = SortingType.allCases

    private(set) var cellModels: [RestaurantCellViewModelProtocol] = []
    private var restaurants: [Restaurant] = []
    var selectedSortingType: SortingType = .openingStatus
    private let service: RestaurantsServiceProtocol

    enum SortingType: String, CaseIterable {
        case openingStatus = "Opening Status"
        case bestMatch = "best match"
        case newest = "newest"
        case ratingAverage = "rating average"
        case distance = "distance"
        case popularity = "popularity"
        case averageProductPrice = "average product price"
        case deliveryCosts = "delivery costs"
        case minCost = "min cost"
    }

    init(service: RestaurantsServiceProtocol) {
        self.service = service
    }

    func loadRestaurants() {
        service.loadRestaurants { [weak self] restaurants in
            self?.restaurants = restaurants
            self?.sortCells()
            self?.generateCellsViewModels()
            self?.loadDataHandler()
        }
    }

    func selectSortAt(index: Int) {
        self.selectedSortingType = SortingType.allCases[index]
    }

    private func generateCellsViewModels() {
        cellModels = restaurants.map({ RestaurantCellViewModel(
            name: $0.name,
            status: $0.status.rawValue,
            sortingTitle: $0.sortingValues.minCost.description,
            sortingValue: $0.sortingValues.minCost.description)
        })
    }

    private func sortCells() {
        restaurants.sort { restaurant1, restaurant2 in
            if restaurant1.status == .open {
                return true
            }
            if restaurant2.status == .open {
                return false
            }
            if restaurant1.status == .orderAhead {
                return true
            }
            if restaurant2.status == .orderAhead {
                return false
            }
            return true
        }
    }
}
