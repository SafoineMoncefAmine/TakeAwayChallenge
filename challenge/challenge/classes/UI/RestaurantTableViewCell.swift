import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet weak var sortingtypeLabel: UILabel!
    @IBOutlet weak var sortingValueLabel: UILabel!

    func setViewModel(_ viewModel: RestaurantCellViewModelProtocol) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        sortingtypeLabel.text = viewModel.sortingTitle
        sortingValueLabel.text = viewModel.sortingValue
    }
}

protocol RestaurantCellViewModelProtocol {
    var name: String { get }
    var status: String { get }
    var sortingTitle: String { get }
    var sortingValue: String { get }
}

struct RestaurantCellViewModel: RestaurantCellViewModelProtocol {
    var name: String
    var status: String
    var sortingTitle: String
    var sortingValue: String
}
