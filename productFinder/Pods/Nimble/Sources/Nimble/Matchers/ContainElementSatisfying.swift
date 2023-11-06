public func containElementSatisfying<S: Sequence>(
    _ matcher: @escaping ((S.Element) -> Bool), _ matcherDescription: String = ""
) -> Matcher<S> {
    Matcher.define { actualExpression in
        let message: ExpectationMessage
        if matcherDescription == "" {
            message = .expectedTo("find object in collection that satisfies matcher")
        } else {
            message = .expectedTo("find object in collection \(matcherDescription)")
        }

        if let sequence = try actualExpression.evaluate() {
            for object in sequence where matcher(object) {
                return MatcherResult(bool: true, message: message)
            }

            return MatcherResult(bool: false, message: message)
        }

        return MatcherResult(status: .fail, message: message)
    }
}

public func containElementSatisfying<S: Sequence>(
    _ matcher: @escaping ((S.Element) async -> Bool), _ matcherDescription: String = ""
) -> AsyncMatcher<S> {
    AsyncMatcher.define { actualExpression in
        let message: ExpectationMessage
        if matcherDescription == "" {
            message = .expectedTo("find object in collection that satisfies matcher")
        } else {
            message = .expectedTo("find object in collection \(matcherDescription)")
        }

        if let sequence = try await actualExpression.evaluate() {
            for object in sequence where await matcher(object) {
                return MatcherResult(bool: true, message: message)
            }

            return MatcherResult(bool: false, message: message)
        }

        return MatcherResult(status: .fail, message: message)
    }
}

#if canImport(Darwin)
    import protocol Foundation.NSFastEnumeration
    import struct Foundation.NSFastEnumerationIterator
    import class Foundation.NSObject

    public extension NMBMatcher {
        @objc class func containElementSatisfyingMatcher(_ matcher: @escaping ((NSObject) -> Bool)) -> NMBMatcher {
            NMBMatcher { actualExpression in
                let value = try actualExpression.evaluate()
                guard let enumeration = value as? NSFastEnumeration else {
                    let message = ExpectationMessage.fail(
                        "containElementSatisfying must be provided an NSFastEnumeration object"
                    )
                    return NMBMatcherResult(status: .fail, message: message.toObjectiveC())
                }

                let message = ExpectationMessage
                    .expectedTo("find object in collection that satisfies matcher")
                    .toObjectiveC()

                var iterator = NSFastEnumerationIterator(enumeration)
                while let item = iterator.next() {
                    guard let object = item as? NSObject else {
                        continue
                    }

                    if matcher(object) {
                        return NMBMatcherResult(status: .matches, message: message)
                    }
                }

                return NMBMatcherResult(status: .doesNotMatch, message: message)
            }
        }
    }
#endif
