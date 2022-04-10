@testable import challenge
import XCTest

class StatusExtensionTests: XCTestCase {
    func test_comparison_shouldReturnRightValue() {
        XCTAssertTrue(Status.open > Status.closed)
        XCTAssertTrue(Status.open > Status.orderAhead)
        XCTAssertFalse(Status.closed > Status.orderAhead)
        XCTAssertFalse(Status.orderAhead > Status.open)
    }
}
