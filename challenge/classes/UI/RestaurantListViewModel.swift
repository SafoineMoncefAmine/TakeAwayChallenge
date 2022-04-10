import Foundation

class RestaurantListViewModel {

    var loadDataHandler: () -> Void = { }
    var sortTypes: [SortingType] = SortingType.allCases

    private(set) var cellModels: [RestaurantCellViewModelProtocol] = []
    private(set) var selectedSortingType: SortingType = .openingStatus
    private var restaurants: [Restaurant] = []
    private let service: RestaurantsServiceProtocol

    init(service: RestaurantsServiceProtocol) {
        self.service = service
    }

    func loadRestaurants() {
        service.loadRestaurants { [weak self] restaurants in
            self?.restaurants = restaurants
            self?.refreshCells()
        }
    }

    func selectSortAt(index: Int) {
        selectedSortingType = SortingType.allCases[index]
        refreshCells()
    }

    private func generateCellsViewModels() {
        cellModels = restaurants.map({ RestaurantCellViewModel(
            name: $0.name,
            status: $0.status.rawValue,
            sortingTitle: selectedSortingType.rawValue,
            sortingValue: $0.sortingValues[selectedSortingType]?.description ?? "")
        })
    }

    private func sortCells() {
        if selectedSortingType == .openingStatus { sortByOpeningStatus(); return }
        restaurants.sort(by: {
            $0.sortingValues[selectedSortingType] ?? .zero < $1.sortingValues[selectedSortingType] ?? .zero
        })
    }

    private func sortByOpeningStatus() {
        restaurants.sort {
            if $0.status == .open { return true }
            if $1.status == .open { return false }
            if $0.status == .orderAhead { return true }
            if $1.status == .orderAhead { return false }
            return true
        }
    }

    private func refreshCells() {
        sortCells()
        generateCellsViewModels()
        loadDataHandler()
    }
}
