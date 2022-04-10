@testable import challenge
import XCTest

class StatusTests: XCTestCase {
    func test_rawValue_ShouldHaveRightValue() {
        XCTAssertEqual(Status.open.rawValue, "open")
        XCTAssertEqual(Status.closed.rawValue, "closed")
        XCTAssertEqual(Status.orderAhead.rawValue, "order ahead")
    }
}
