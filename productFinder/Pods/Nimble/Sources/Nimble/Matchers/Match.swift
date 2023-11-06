/// A Nimble matcher that succeeds when the actual string satisfies the regular expression
/// described by the expected string.
public func match(_ expectedValue: String?) -> Matcher<String> {
    Matcher.simple("match <\(stringify(expectedValue))>") { actualExpression in
        guard let actual = try actualExpression.evaluate(), let regexp = expectedValue else { return .fail }

        let bool = actual.range(of: regexp, options: .regularExpression) != nil
        return MatcherStatus(bool: bool)
    }
}

#if canImport(Darwin)
    import class Foundation.NSString

    public extension NMBMatcher {
        @objc class func matchMatcher(_ expected: NSString) -> NMBMatcher {
            NMBMatcher { actualExpression in
                let actual = actualExpression.cast { $0 as? String }
                return try match(expected.description).satisfies(actual).toObjectiveC()
            }
        }
    }
#endif
