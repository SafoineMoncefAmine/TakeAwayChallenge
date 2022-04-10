import Foundation

protocol RestaurantsServiceProtocol {
    func loadRestaurants(completion: @escaping ([Restaurant]) -> Void)
}

class RestaurantsService: RestaurantsServiceProtocol {
    var dataLoader: DataLoaderProtocol
    init(loader: DataLoaderProtocol) {
        dataLoader = loader
    }

    func loadRestaurants(completion: @escaping ([Restaurant]) -> Void) {
        dataLoader.load(fileName: "data", completion: { result in
            switch result {
            case .success(let data):
                let restaurants = try? RestaurantMapper.map(data)
                completion(restaurants ?? [])
            case .failure(let error):
                completion([])
                log.error("Error Can't load data \(error)")
            }
        })
    }
}
