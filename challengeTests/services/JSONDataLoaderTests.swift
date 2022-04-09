@testable import challenge
import XCTest

class JSONDataLoaderTests: XCTestCase {
    func test_load_shouldthrowError_whenFileNotFound() {}

    private func makeSUT() -> JSONDataLoader {
        return JSONDataLoader()
    }
}
