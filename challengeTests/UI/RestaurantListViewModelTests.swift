import Foundation
@testable import challenge
import XCTest

class RestaurantListViewModelTests: XCTestCase {

    func test_loadRestaurants_shouldLoadDataAndCallLoadHandler() {
        let mockService = MockRestaurantsService()
        let viewModel = makeSUT(service: mockService)
        var loadHandlerInvoked = false
        viewModel.loadDataHandler = { loadHandlerInvoked = true }
        viewModel.loadRestaurants()
        XCTAssertTrue(mockService.loadInvocations.count == 1)
        mockService.loadInvocations.first?(makeRestaurants())
        XCTAssertTrue(loadHandlerInvoked)
    }

    func test_loadRestaurants_shouldGenerateCellsModels() {
        let mockService = MockRestaurantsService()
        let viewModel = makeSUT(service: mockService)
        viewModel.loadRestaurants()
        XCTAssertTrue(mockService.loadInvocations.count == 1)
        mockService.loadInvocations.first?(makeRestaurants())
        XCTAssertEqual(viewModel.cellModels.count, 6)
    }

    func test_sortbyOpeningStatus_shouldOrderCells() {
        let mockService = MockRestaurantsService()
        let viewModel = makeSUT(service: mockService)
        viewModel.loadRestaurants()
        mockService.loadInvocations.first?(makeRestaurants())
        viewModel.selectSortAt(index: SortingType.allCases.firstIndex(of: .openingStatus)!)
        XCTAssertEqual(viewModel.cellModels[0].name, "res1 searched")
        XCTAssertEqual(viewModel.cellModels[1].name, "res5")
        XCTAssertEqual(viewModel.cellModels[2].name, "res4 searched")
        XCTAssertEqual(viewModel.cellModels[3].name, "res6")
        XCTAssertEqual(viewModel.cellModels[4].name, "res2")
        XCTAssertEqual(viewModel.cellModels[5].name, "res3 searched")
    }

    func test_sortbySortingType_shouldOrderCells() {
        let mockService = MockRestaurantsService()
        let viewModel = makeSUT(service: mockService)
        viewModel.loadRestaurants()
        mockService.loadInvocations.first?(makeRestaurants())
        viewModel.selectSortAt(index: SortingType.allCases.firstIndex(of: .distance)!)
        XCTAssertEqual(viewModel.cellModels[0].name, "res3 searched")
        XCTAssertEqual(viewModel.cellModels[1].name, "res4 searched")
        XCTAssertEqual(viewModel.cellModels[2].name, "res2")
        XCTAssertEqual(viewModel.cellModels[3].name, "res6")
        XCTAssertEqual(viewModel.cellModels[4].name, "res1 searched")
        XCTAssertEqual(viewModel.cellModels[5].name, "res5")
    }

    func test_search_shouldFilterRestaurants() {
        let mockService = MockRestaurantsService()
        let viewModel = makeSUT(service: mockService)
        viewModel.loadRestaurants()
        mockService.loadInvocations.first?(makeRestaurants())
        viewModel.search(name: "searched")
        XCTAssertEqual(viewModel.cellModels.count, 3)
    }

    func test_search_shouldKeepAllRestaurants_whenSearchedTextIsEmpty() {
        let mockService = MockRestaurantsService()
        let viewModel = makeSUT(service: mockService)
        viewModel.loadRestaurants()
        mockService.loadInvocations.first?(makeRestaurants())
        viewModel.search(name: "")
        XCTAssertEqual(viewModel.cellModels.count, 6)
    }

    func test_search_shouldKeepAllRestaurants_whenSearchedTextIsNil() {
        let mockService = MockRestaurantsService()
        let viewModel = makeSUT(service: mockService)
        viewModel.loadRestaurants()
        mockService.loadInvocations.first?(makeRestaurants())
        viewModel.search(name: nil)
        XCTAssertEqual(viewModel.cellModels.count, 6)
    }

    private func makeSUT(service: RestaurantsServiceProtocol) -> RestaurantListViewModel {
        return RestaurantListViewModel(service: service)
    }
    private func makeRestaurants() -> [Restaurant] {
        return [
            Restaurant(name: "res1 searched", status: .open, sortingValues: [.distance: 33]),
            Restaurant(name: "res2", status: .closed, sortingValues: [.distance: 100]),
            Restaurant(name: "res3 searched", status: .closed, sortingValues: [.distance: 711]),
            Restaurant(name: "res4 searched", status: .orderAhead, sortingValues: [.distance: 342]),
            Restaurant(name: "res5", status: .open, sortingValues: [.distance: 22]),
            Restaurant(name: "res6", status: .orderAhead, sortingValues: [.distance: 42])
        ]
    }
}
