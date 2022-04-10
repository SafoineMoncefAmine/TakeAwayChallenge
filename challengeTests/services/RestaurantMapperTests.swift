import XCTest
@testable import challenge

// swiftlint:disable force_try

class RestaurantMapperTests: XCTestCase {
    func test_map_shouldConvertReceivedDataToListOfRestaurants() {
        let mappedRestaurants = try? RestaurantMapper.map(makeData())
        XCTAssertEqual(mappedRestaurants?.count, 7)
        let restaurant = mappedRestaurants?.first
        XCTAssertEqual(restaurant?.name, "Tanoshii Sushi")
        XCTAssertEqual(restaurant?.status, .open)
        XCTAssertEqual(restaurant?.sortingValues[.openingStatus], nil)
        XCTAssertEqual(restaurant?.sortingValues[.ratingAverage], 4.5)
        XCTAssertEqual(restaurant?.sortingValues[.newest], 96.0)
        XCTAssertEqual(restaurant?.sortingValues[.bestMatch], 0.0)
        XCTAssertEqual(restaurant?.sortingValues[.minCost], 1000.0)
        XCTAssertEqual(restaurant?.sortingValues[.averageProductPrice], 1536.0)
        XCTAssertEqual(restaurant?.sortingValues[.deliveryCosts], 200.0)
        XCTAssertEqual(restaurant?.sortingValues[.distance], 1190.0)
    }

    func test_map_shouldThrowError_WhenDataIsInvalid() {
        let restaurants = try? RestaurantMapper.map(makeInvalidData())
        XCTAssertNil(restaurants)
    }

    private func makeData() -> Data {
        return try! Data(contentsOf:
                        URL(fileURLWithPath:
                                Bundle(for: type(of: self)).path(forResource: "testData", ofType: "json")!
                           )
        )
    }
    private func makeInvalidData() -> Data {
        return try! Data(contentsOf:
                        URL(fileURLWithPath:
                                Bundle(for: type(of: self)).path(forResource: "InvalidtestData", ofType: "json")!
                           )
        )
    }
}
