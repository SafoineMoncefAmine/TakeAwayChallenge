import Foundation

class RestaurantListViewModel {

    var loadDataHandler: () -> Void = { }
    var sortTypes: [SortingType] = SortingType.allCases
    var selectedSortingTitle: String {
        "sorted by: " + selectedSortType.rawValue
    }

    private(set) var cellModels: [RestaurantCellViewModelProtocol] = []
    private var selectedSortType: SortingType = .openingStatus
    private var restaurants: [Restaurant] = []
    private var filtredRestaurants: [Restaurant] = []
    private let service: RestaurantsServiceProtocol

    init(service: RestaurantsServiceProtocol) {
        self.service = service
    }

    func loadRestaurants() {
        service.loadRestaurants { [weak self] restaurants in
            self?.restaurants = restaurants
            self?.filtredRestaurants = restaurants
            self?.refreshCells()
        }
    }

    func selectSortAt(index: Int) {
        selectedSortType = SortingType.allCases[index]
        refreshCells()
    }

    func search(name: String?) {
        guard let name = name, !name.isEmpty else {
            filtredRestaurants = restaurants
            refreshCells()
            return
        }
        filtredRestaurants = restaurants.filter({ $0.name.contains(name)})
        refreshCells()
    }

    private func generateCellsViewModels() {
        cellModels = filtredRestaurants.map({ RestaurantCellViewModel(
            name: $0.name,
            status: $0.status.rawValue,
            sortingTitle: selectedSortType.rawValue,
            sortingValue: $0.sortingValues[selectedSortType]?.description ?? "",
            isSortingVisible: selectedSortType != .openingStatus)
        })
    }

    private func sortRestaurants() {
        if selectedSortType == .openingStatus { sortByOpeningStatus(); return }
        filtredRestaurants.sort(by: {
            $0.sortingValues[selectedSortType] ?? .zero > $1.sortingValues[selectedSortType] ?? .zero
        })
    }

    private func sortByOpeningStatus() {
        filtredRestaurants.sort {
            if $0.status == .open { return true }
            if $1.status == .open { return false }
            if $0.status == .orderAhead { return true }
            if $1.status == .orderAhead { return false }
            return true
        }
    }

    private func refreshCells() {
        sortRestaurants()
        generateCellsViewModels()
        loadDataHandler()
    }
}
