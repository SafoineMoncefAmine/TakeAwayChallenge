import XCTest
@testable import challenge

// swiftlint:disable force_try

class RestaurantsServiceTests: XCTestCase {

    func test_load_shouldCompletWithListOfRestaurants() {
        let mockDataLoader = MockJSONDataLoader()
        let service = makeSUT(dataLoader: mockDataLoader)
        var expectedRestaurants: [Restaurant] = []
        var completionInvoked = false
        service.loadRestaurants { restaurants in
            expectedRestaurants = restaurants
            completionInvoked = true
        }
        mockDataLoader.loadInvocation.first?(.success(makeData()))
        XCTAssertFalse(expectedRestaurants.isEmpty)
        XCTAssertTrue(completionInvoked)
    }

    func test_load_shouldCompletWithEmptyList_whenSucceesHasInvalidData() {
        let mockDataLoader = MockJSONDataLoader()
        let service = makeSUT(dataLoader: mockDataLoader)
        var expectedRestaurants: [Restaurant] = []
        var completionInvoked = false
        service.loadRestaurants { restaurants in
            expectedRestaurants = restaurants
            completionInvoked = true
        }
        mockDataLoader.loadInvocation.first?(.success(makeInvalidData()))
        XCTAssertTrue(expectedRestaurants.isEmpty)
        XCTAssertTrue(completionInvoked)
    }

    func test_load_shouldCompletEmptyListOfRestaurants_whenFinishWithError() {
        let mockDataLoader = MockJSONDataLoader()
        let service = makeSUT(dataLoader: mockDataLoader)
        var expectedRestaurants: [Restaurant] = []
        var completionInvoked = false
        service.loadRestaurants { restaurants in
            expectedRestaurants = restaurants
            completionInvoked = true
        }
        mockDataLoader.loadInvocation.first?(.failure(anyNSError()))
        XCTAssertTrue(expectedRestaurants.isEmpty)
        XCTAssertTrue(completionInvoked)
    }

    func makeSUT(dataLoader: DataLoaderProtocol) -> RestaurantsService {
        return RestaurantsService(loader: dataLoader)
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
