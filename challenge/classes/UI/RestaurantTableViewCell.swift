import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet weak var sortingtypeLabel: UILabel!
    @IBOutlet weak var sortingValueLabel: UILabel!
    @IBOutlet weak var sortingStackView: UIStackView!

    override func awakeFromNib() {
        setupUI()
    }

    func setViewModel(_ viewModel: RestaurantCellViewModelProtocol) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        sortingtypeLabel.text = viewModel.sortingTitle + ": "
        sortingValueLabel.text = viewModel.sortingValue
        sortingStackView.isHidden = !viewModel.isSortingVisible
    }

    private func setupUI() {
        nameLabel.font = .boldSystemFont(ofSize: 15)
        statusLabel.font = .italicSystemFont(ofSize: 12)
        statusLabel.textColor = .gray
        sortingtypeLabel.font = .boldSystemFont(ofSize: 12)
        sortingValueLabel.font = .systemFont(ofSize: 12)
    }
}
