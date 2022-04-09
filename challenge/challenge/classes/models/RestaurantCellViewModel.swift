import Foundation

protocol RestaurantCellViewModelProtocol {
    var name: String { get }
    var status: String { get }
    var sortingTitle: String { get }
    var sortingValue: String { get }
}

struct RestaurantCellViewModel: RestaurantCellViewModelProtocol {
    let name: String
    let status: String
    let sortingTitle: String
    let sortingValue: String
}
