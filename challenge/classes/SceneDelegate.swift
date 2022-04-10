import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.frame = UIScreen.main.bounds
            let service = RestaurantsService(loader: JSONDataLoader())
            let viewModel = RestaurantListViewModel(service: service)
            window.rootViewController = RestaurantListViewController(viewModel: viewModel)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
