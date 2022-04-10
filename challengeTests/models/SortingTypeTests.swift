@testable import challenge
import XCTest

class SortingTypeTests: XCTestCase {
    func test_rawValue_shouldHaveRightValue() {
        XCTAssertEqual(SortingType.openingStatus.rawValue, "opening status")
        XCTAssertEqual(SortingType.newest.rawValue, "newest")
        XCTAssertEqual(SortingType.bestMatch.rawValue, "best match")
        XCTAssertEqual(SortingType.distance.rawValue, "distance")
        XCTAssertEqual(SortingType.ratingAverage.rawValue, "rating average")
        XCTAssertEqual(SortingType.popularity.rawValue, "popularity")
        XCTAssertEqual(SortingType.deliveryCosts.rawValue, "delivery costs")
        XCTAssertEqual(SortingType.averageProductPrice.rawValue, "average price")
        XCTAssertEqual(SortingType.minCost.rawValue, "min cost")
    }
}
