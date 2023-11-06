/// A protocol which represents whether the value is nil or not.
private protocol _OptionalProtocol {
    var isNil: Bool { get }
}

extension Optional: _OptionalProtocol {
    var isNil: Bool { self == nil }
}

/// A Nimble matcher that succeeds when the actual value is nil.
public func beNil<T>() -> Matcher<T> {
    Matcher.simpleNilable("be nil") { actualExpression in
        let actualValue = try actualExpression.evaluate()
        if let actual = actualValue, let nestedOptionl = actual as? _OptionalProtocol {
            return MatcherStatus(bool: nestedOptionl.isNil)
        }
        return MatcherStatus(bool: actualValue == nil)
    }
}

/// Represents `nil` value to be used with the operator overloads for `beNil`.
public struct ExpectationNil: ExpressibleByNilLiteral {
    public init(nilLiteral _: ()) {}
}

public extension SyncExpectation {
    static func == (lhs: SyncExpectation, _: ExpectationNil) {
        lhs.to(beNil())
    }

    static func != (lhs: SyncExpectation, _: ExpectationNil) {
        lhs.toNot(beNil())
    }
}

public extension AsyncExpectation {
    static func == (lhs: AsyncExpectation, _: ExpectationNil) async {
        await lhs.to(beNil())
    }

    static func != (lhs: AsyncExpectation, _: ExpectationNil) async {
        await lhs.toNot(beNil())
    }
}

#if canImport(Darwin)
    import Foundation

    public extension NMBMatcher {
        @objc class func beNilMatcher() -> NMBMatcher {
            NMBMatcher { actualExpression in
                try beNil().satisfies(actualExpression).toObjectiveC()
            }
        }
    }
#endif
