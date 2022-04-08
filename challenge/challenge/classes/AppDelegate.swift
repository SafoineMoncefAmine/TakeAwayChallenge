import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        RestaurantsService(loader: JSONDataLoader()).loadRestaurants { restaurants in
            print(restaurants)
        }
        return true
    }
}
