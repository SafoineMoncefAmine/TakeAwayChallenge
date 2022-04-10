@testable import challenge
import XCTest

class JSONDataLoaderTests: XCTestCase {

    func test_load_shouldthrowError_whenFileNotFound() {
        let loader = makeSUT()
        loader.load(fileName: "unexistedName") { result in
            if case .success = result {
                XCTFail("This should complete with error ")
            }
        }
    }

    func test_load_shouldCompleteWithData_When_fileIsFOund() {
        let loader = makeSUT()
        loader.load(fileName: "data") { result in
            if case .failure = result {
                XCTFail("This should complete with success")
            }
        }
    }

    private func makeSUT() -> JSONDataLoader {
        return JSONDataLoader()
    }
}
