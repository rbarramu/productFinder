import Foundation

class NetworkServiceLocator {
    private var config: URLSessionConfiguration {
        URLSessionConfiguration.default
    }

    var session: URLSession {
        URLSession(configuration: config)
    }
}
