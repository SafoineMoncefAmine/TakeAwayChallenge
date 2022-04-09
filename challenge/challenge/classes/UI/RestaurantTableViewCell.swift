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
