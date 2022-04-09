import UIKit

class RestaurantListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

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
        setupHandlers()
        viewModel.loadRestaurants()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "RestaurantTableViewCell", bundle: nil),
            forCellReuseIdentifier: "RestaurantTableViewCell"
        )
    }

    private func setupHandlers() {
        self.tableView.reloadData()
    }
}

extension RestaurantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell") else {
            return UITableViewCell()
        }
        return cell
    }
}
