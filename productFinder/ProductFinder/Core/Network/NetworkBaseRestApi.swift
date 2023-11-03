import Foundation

class NetworkBaseRestApi<T, D>: NetworkRestApi {
    var domainNetwork: DomainNetworkBase<T>
    var session: URLSession

    var network: D {
        // swiftlint:disable:next force_cast
        domainNetwork as! D
    }

    required init(domainNetwork: DomainNetworkBase<T>, session: URLSession) {
        self.domainNetwork = domainNetwork
        self.session = session
    }
}
