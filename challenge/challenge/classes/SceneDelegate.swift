import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.frame = UIScreen.main.bounds
            window.rootViewController = RestaurantListViewController(
                viewModel: RestaurantListViewModel(service: RestaurantsService(loader: JSONDataLoader()))
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
