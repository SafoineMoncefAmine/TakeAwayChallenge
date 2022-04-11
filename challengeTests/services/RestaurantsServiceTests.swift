import XCTest
@testable import challenge

// swiftlint:disable force_try

class RestaurantsServiceTests: XCTestCase {

    func test_load_shouldCompletWithListOfRestaurants() {
        let mockDataLoader = MockJSONDataLoader()
        let service = makeSUT(dataLoader: mockDataLoader)
        var expectedRestaurants: [Restaurant] = []
        var completionInvoked = false
        service.loadRestaurants { result in
            if case .success(let restaurants) = result {
                expectedRestaurants = restaurants
                completionInvoked = true
            }
        }
        mockDataLoader.loadInvocation.first?(.success(makeData()))
        XCTAssertFalse(expectedRestaurants.isEmpty)
        XCTAssertTrue(completionInvoked)
    }

    func test_load_shouldCompletError_whenHasInvalidData() {
        let mockDataLoader = MockJSONDataLoader()
        let service = makeSUT(dataLoader: mockDataLoader)
        var completionInvoked = false
        service.loadRestaurants { result in
            completionInvoked = true
            if case .success = result {
                XCTFail("should complete with faillure")
            }
        }
        mockDataLoader.loadInvocation.first?(.success(makeInvalidData()))
        XCTAssertTrue(completionInvoked)
    }

    func test_load_shouldCompleteWithError_whenSericeFails() {
        let mockDataLoader = MockJSONDataLoader()
        let service = makeSUT(dataLoader: mockDataLoader)
        var completionInvoked = false
        service.loadRestaurants { result in
            completionInvoked = true
            if case .success = result {
                XCTFail("should complete with faillure")
            }
        }
        mockDataLoader.loadInvocation.first?(.failure(anyNSError()))
        XCTAssertTrue(completionInvoked)
    }

    func makeSUT(dataLoader: DataLoaderProtocol,
                 file: StaticString = #filePath,
                 line: UInt = #line) -> RestaurantsService {
        let sut = RestaurantsService(loader: dataLoader)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
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
