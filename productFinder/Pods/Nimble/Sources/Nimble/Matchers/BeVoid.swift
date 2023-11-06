/// A Nimble matcher that succeeds when the actual value is Void.
public func beVoid() -> Matcher<Void> {
    Matcher.simpleNilable("be void") { actualExpression in
        let actualValue: ()? = try actualExpression.evaluate()
        return MatcherStatus(bool: actualValue != nil)
    }
}

public func == (lhs: SyncExpectation<Void>, _: ()) {
    lhs.to(beVoid())
}

public func == (lhs: AsyncExpectation<Void>, _: ()) async {
    await lhs.to(beVoid())
}

public func != (lhs: SyncExpectation<Void>, _: ()) {
    lhs.toNot(beVoid())
}

public func != (lhs: AsyncExpectation<Void>, _: ()) async {
    await lhs.toNot(beVoid())
}
