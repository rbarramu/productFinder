enum EnvironmentHelper {
    #if DEBUG
        static var current: Environment = .stubbed
    #elseif ADHOC
        static var current: Environment = .debug
    #else
        static var current: Environment = .release
    #endif
}
