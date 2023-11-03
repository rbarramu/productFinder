import Lottie
import UIKit

final class SplashViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        prepareAnimation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = Theme.current.primaryBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // Show animation from lottie
    private func prepareAnimation() {
        let view = AnimationView()
        let path = Bundle.main.path(forResource: "SplashAnimation",
                                    ofType: "json") ?? Constants.empty
        view.animation = Animation.filepath(path)
        view.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        view.contentMode = .scaleAspectFit
        view.center = self.view.center
        view.loopMode = .loop
        self.view.addSubview(view)
        view.play()
        timeWait()
    }

    // Time delay to go from one view to another
    private func timeWait() {
        let when = DispatchTime.now() + 2.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.showSearchView()
        }
    }

    private func showSearchView() {
        let viewController = ViewFactory(serviceLocator: ProductFinderServiceLocator()).viewController(type: .search)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
