import Foundation
@testable import challenge

class MockRestaurantsService: RestaurantsServiceProtocol {
    var loadInvocations: [([Restaurant]) -> Void] = []
    func loadRestaurants(completion: @escaping ([Restaurant]) -> Void) {
        loadInvocations.append(completion)
    }
}
