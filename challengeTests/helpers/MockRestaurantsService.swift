import Foundation
@testable import challenge

class MockRestaurantsService: RestaurantsServiceProtocol {
    var loadInvocations: [(Result<[Restaurant], Error>) -> Void] = []
    func loadRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        loadInvocations.append(completion)
    }
}
