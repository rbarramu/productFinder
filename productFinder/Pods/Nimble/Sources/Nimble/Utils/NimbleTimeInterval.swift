#if !os(WASI)

    import Dispatch

    #if canImport(CDispatch)
        import CDispatch
    #endif

    /// A reimplementation of `DispatchTimeInterval` without the `never` case, and conforming to `Sendable`.
    public enum NimbleTimeInterval: Sendable, Equatable {
        case seconds(Int)
        case milliseconds(Int)
        case microseconds(Int)
        case nanoseconds(Int)
    }

    extension NimbleTimeInterval: CustomStringConvertible {
        public var dispatchTimeInterval: DispatchTimeInterval {
            switch self {
            case let .seconds(int):
                return .seconds(int)
            case let .milliseconds(int):
                return .milliseconds(int)
            case let .microseconds(int):
                return .microseconds(int)
            case let .nanoseconds(int):
                return .nanoseconds(int)
            }
        }

        // ** Note: We cannot simply divide the time interval because NimbleTimeInterval associated value type is Int
        internal var divided: NimbleTimeInterval {
            switch self {
            case let .seconds(val): return val < 2 ? .milliseconds(Int(Float(val) / 2 * 1000)) : .seconds(val / 2)
            case let .milliseconds(val): return .milliseconds(val / 2)
            case let .microseconds(val): return .microseconds(val / 2)
            case let .nanoseconds(val): return .nanoseconds(val / 2)
            }
        }

        public var nanoseconds: UInt64 {
            switch self {
            case let .seconds(int): return UInt64(int) * 1_000_000_000
            case let .milliseconds(int): return UInt64(int) * 1_000_000
            case let .microseconds(int): return UInt64(int) * 1000
            case let .nanoseconds(int): return UInt64(int)
            }
        }

        public var description: String {
            switch self {
            case let .seconds(val): return val == 1 ? "\(Float(val)) second" : "\(Float(val)) seconds"
            case let .milliseconds(val): return "\(Float(val) / 1000) seconds"
            case let .microseconds(val): return "\(Float(val) / 1_000_000) seconds"
            case let .nanoseconds(val): return "\(Float(val) / 1_000_000_000) seconds"
            }
        }
    }

    #if canImport(Foundation)
        import Foundation

        public extension NimbleTimeInterval {
            var timeInterval: TimeInterval {
                switch self {
                case let .seconds(int): return TimeInterval(int)
                case let .milliseconds(int): return TimeInterval(int) / 1000
                case let .microseconds(int): return TimeInterval(int) / 1_000_000
                case let .nanoseconds(int): return TimeInterval(int) / 1_000_000_000
                }
            }
        }

        public extension TimeInterval {
            var nimbleInterval: NimbleTimeInterval {
                let microseconds = Int64(self * TimeInterval(USEC_PER_SEC))
                // perhaps use nanoseconds, though would more often be > Int.max
                return microseconds < Int.max ? .microseconds(Int(microseconds)) : .seconds(Int(self))
            }
        }

        public extension Date {
            func advanced(by nimbleTimeInterval: NimbleTimeInterval) -> Date {
                advanced(by: nimbleTimeInterval.timeInterval)
            }
        }
    #endif

#endif // #if !os(WASI)
