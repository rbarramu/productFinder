/// Make a ``SyncExpectation`` on a given actual value. The value given is lazily evaluated.
public func expect<T>(file: FileString = #file, line: UInt = #line, _ expression: @autoclosure @escaping () throws -> T?) -> SyncExpectation<T> {
    SyncExpectation(
        expression: Expression(
            expression: expression,
            location: SourceLocation(file: file, line: line),
            isClosure: true
        ))
}

/// Make a ``SyncExpectation`` on a given actual value. The closure is lazily invoked.
public func expect<T>(file: FileString = #file, line: UInt = #line, _ expression: @autoclosure () -> (() throws -> T)) -> SyncExpectation<T> {
    SyncExpectation(
        expression: Expression(
            expression: expression(),
            location: SourceLocation(file: file, line: line),
            isClosure: true
        ))
}

/// Make a ``SyncExpectation`` on a given actual value. The closure is lazily invoked.
public func expect<T>(file: FileString = #file, line: UInt = #line, _ expression: @autoclosure () -> (() throws -> T?)) -> SyncExpectation<T> {
    SyncExpectation(
        expression: Expression(
            expression: expression(),
            location: SourceLocation(file: file, line: line),
            isClosure: true
        ))
}

/// Make a ``SyncExpectation`` on a given actual value. The closure is lazily invoked.
public func expect(file: FileString = #file, line: UInt = #line, _ expression: @autoclosure () -> (() throws -> Void)) -> SyncExpectation<Void> {
    SyncExpectation(
        expression: Expression(
            expression: expression(),
            location: SourceLocation(file: file, line: line),
            isClosure: true
        ))
}

/// Make a ``SyncExpectation`` on a given actual value. The value given is lazily evaluated.
/// This is provided as an alternative to `expect` which avoids overloading with `expect -> AsyncExpectation`.
public func expects<T>(file: FileString = #file, line: UInt = #line, _ expression: @autoclosure @escaping () throws -> T?) -> SyncExpectation<T> {
    SyncExpectation(
        expression: Expression(
            expression: expression,
            location: SourceLocation(file: file, line: line),
            isClosure: true
        ))
}

/// Make a ``SyncExpectation`` on a given actual value. The closure is lazily invoked.
/// This is provided as an alternative to `expect` which avoids overloading with `expect -> AsyncExpectation`.
public func expects<T>(file: FileString = #file, line: UInt = #line, _ expression: @autoclosure () -> (() throws -> T)) -> SyncExpectation<T> {
    SyncExpectation(
        expression: Expression(
            expression: expression(),
            location: SourceLocation(file: file, line: line),
            isClosure: true
        ))
}

/// Make a ``SyncExpectation`` on a given actual value. The closure is lazily invoked.
/// This is provided as an alternative to `expect` which avoids overloading with `expect -> AsyncExpectation`.
public func expects<T>(file: FileString = #file, line: UInt = #line, _ expression: @autoclosure () -> (() throws -> T?)) -> SyncExpectation<T> {
    SyncExpectation(
        expression: Expression(
            expression: expression(),
            location: SourceLocation(file: file, line: line),
            isClosure: true
        ))
}

/// Make a ``SyncExpectation`` on a given actual value. The closure is lazily invoked.
/// This is provided as an alternative to `expect` which avoids overloading with `expect -> AsyncExpectation`.
public func expects(file: FileString = #file, line: UInt = #line, _ expression: @autoclosure () -> (() throws -> Void)) -> SyncExpectation<Void> {
    SyncExpectation(
        expression: Expression(
            expression: expression(),
            location: SourceLocation(file: file, line: line),
            isClosure: true
        ))
}

/// Always fails the test with a message and a specified location.
public func fail(_ message: String, location: SourceLocation) {
    let handler = NimbleEnvironment.activeInstance.assertionHandler
    handler.assert(false, message: FailureMessage(stringValue: message), location: location)
}

/// Always fails the test with a message.
public func fail(_ message: String, file: FileString = #file, line: UInt = #line) {
    fail(message, location: SourceLocation(file: file, line: line))
}

/// Always fails the test.
public func fail(_ file: FileString = #file, line: UInt = #line) {
    fail("fail() always fails", file: file, line: line)
}

/// Like Swift's precondition(), but raises NSExceptions instead of sigaborts
internal func nimblePrecondition(
    _ expr: @autoclosure () -> Bool,
    _ name: @autoclosure () -> String,
    _ message: @autoclosure () -> String,
    file: StaticString = #file,
    line: UInt = #line
) {
    let result = expr()
    if !result {
        _nimblePrecondition(name(), message(), file, line)
    }
}

internal func internalError(_ msg: String, file: FileString = #file, line: UInt = #line) -> Never {
    fatalError(
        """
        Nimble Bug Found: \(msg) at \(file):\(line).
        Please file a bug to Nimble: https://github.com/Quick/Nimble/issues with the code snippet that caused this error.
        """
    )
}

#if canImport(Darwin)
    import class Foundation.NSException
    import struct Foundation.NSExceptionName

    private func _nimblePrecondition(
        _ name: String,
        _ message: String,
        _: StaticString,
        _: UInt
    ) {
        let exception = NSException(
            name: NSExceptionName(name),
            reason: message,
            userInfo: nil
        )
        exception.raise()
    }
#else
    private func _nimblePrecondition(
        _ name: String,
        _ message: String,
        _ file: StaticString,
        _ line: UInt
    ) {
        preconditionFailure("\(name) - \(message)", file: file, line: line)
    }
#endif
