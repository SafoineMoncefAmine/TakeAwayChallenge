import UIKit

class RestaurantListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sortPickerView: UIPickerView!
    @IBOutlet private weak var sortTextField: UITextField!
    @IBOutlet private weak var sortView: UIView!
    @IBOutlet private weak var sortingPickerView: UIView!

    private var viewModel: RestaurantListViewModel

    init(viewModel: RestaurantListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPickerView()
        setupHandlers()
        sortView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(togglePickerViewVisibility))
        )
        viewModel.loadRestaurants()
    }

    @objc private func togglePickerViewVisibility() {
        sortingPickerView.isHidden.toggle()
    }
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "RestaurantTableViewCell", bundle: nil),
            forCellReuseIdentifier: "RestaurantTableViewCell"
        )
    }
    private func setupHandlers() {
        self.viewModel.loadDataHandler = { [weak self] in
            self?.tableView.reloadData()
            self?.sortTextField.text = self?.viewModel.selectedSortingTitle
            self?.sortingPickerView.isHidden = true
        }
    }
    private func setupPickerView() {
        sortPickerView.dataSource = self
        sortPickerView.delegate = self
    }
}

extension RestaurantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell")
                as?   RestaurantTableViewCell else {
            return UITableViewCell()
        }
        cell.setViewModel(viewModel.cellModels[indexPath.row])
        return cell
    }
}

extension RestaurantListViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.sortTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.sortTypes[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectSortAt(index: row)
    }
}
