import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            loadStubsIfNeeded()
            let window = UIWindow(windowScene: windowScene)
            let greetingsVC = ViewFactory(serviceLocator: ProductFinderServiceLocator()).viewController(type: .splash)
            let navigationController = UINavigationController(rootViewController: greetingsVC)
            window.backgroundColor = Theme.current.primaryBackground
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func loadStubsIfNeeded() {
        #if DEBUG
            if EnvironmentHelper.current == .stubbed {
                StubService.stubAll()
            }
        #endif
    }

    func sceneDidDisconnect(_: UIScene) {}

    func sceneDidBecomeActive(_: UIScene) {}

    func sceneWillResignActive(_: UIScene) {}

    func sceneWillEnterForeground(_: UIScene) {}

    func sceneDidEnterBackground(_: UIScene) {}
}
