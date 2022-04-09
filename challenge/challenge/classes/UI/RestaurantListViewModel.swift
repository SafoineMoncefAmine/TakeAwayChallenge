import Foundation

class RestaurantListViewModel {

    var loadDataHandler: () -> Void = { }
    private(set) var restaurants: [Restaurant] = []
    private let service: RestaurantsServiceProtocol

    init(service: RestaurantsServiceProtocol) {
        self.service = service
    }

    func loadRestaurants() {
        service.loadRestaurants { [weak self] restaurants in
            self?.restaurants = restaurants
            self?.loadDataHandler()
        }
    }
}
