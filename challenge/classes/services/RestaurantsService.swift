import Foundation

protocol RestaurantsServiceProtocol {
    func loadRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void)
}

class RestaurantsService: RestaurantsServiceProtocol {
    var dataLoader: DataLoaderProtocol
    init(loader: DataLoaderProtocol) {
        dataLoader = loader
    }

    func loadRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        dataLoader.load(fileName: "data", completion: { result in
            switch result {
            case .success(let data):
                do {
                let restaurants = try RestaurantMapper.map(data)
                    completion(.success(restaurants))
                } catch {
                    log.error("Error Can't load data \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                log.error("Error Can't load data \(error)")
                completion(.failure(error))
            }
        })
    }
}
