#if !os(WASI)

    #if canImport(Darwin)
        import class Foundation.NSObject
        import typealias Foundation.TimeInterval

        private func from(objcMatcher: NMBMatcher) -> Matcher<NSObject> {
            Matcher { actualExpression in
                let result = objcMatcher.satisfies(({ try actualExpression.evaluate() }),
                                                   location: actualExpression.location)
                return result.toSwift()
            }
        }

        // Equivalent to Expectation, but for Nimble's Objective-C interface
        public class NMBExpectation: NSObject {
            internal let _actualBlock: () -> NSObject?
            internal var _negative: Bool
            internal let _file: FileString
            internal let _line: UInt
            internal var _timeout: NimbleTimeInterval = .seconds(1)

            @objc public init(actualBlock: @escaping () -> NSObject?, negative: Bool, file: FileString, line: UInt) {
                self._actualBlock = actualBlock
                self._negative = negative
                self._file = file
                self._line = line
            }

            private var expectValue: SyncExpectation<NSObject> {
                expect(file: _file, line: _line, self._actualBlock() as NSObject?)
            }

            @objc public var withTimeout: (TimeInterval) -> NMBExpectation {
                { timeout in self._timeout = timeout.nimbleInterval
                    return self
                }
            }

            @objc public var to: (NMBMatcher) -> NMBExpectation {
                { matcher in
                    self.expectValue.to(from(objcMatcher: matcher))
                    return self
                }
            }

            @objc public var toWithDescription: (NMBMatcher, String) -> NMBExpectation {
                { matcher, description in
                    self.expectValue.to(from(objcMatcher: matcher), description: description)
                    return self
                }
            }

            @objc public var toNot: (NMBMatcher) -> NMBExpectation {
                { matcher in
                    self.expectValue.toNot(from(objcMatcher: matcher))
                    return self
                }
            }

            @objc public var toNotWithDescription: (NMBMatcher, String) -> NMBExpectation {
                { matcher, description in
                    self.expectValue.toNot(from(objcMatcher: matcher), description: description)
                    return self
                }
            }

            @objc public var notTo: (NMBMatcher) -> NMBExpectation { toNot }

            @objc public var notToWithDescription: (NMBMatcher, String) -> NMBExpectation { toNotWithDescription }

            @objc public var toEventually: (NMBMatcher) -> Void {
                { matcher in
                    self.expectValue.toEventually(
                        from(objcMatcher: matcher),
                        timeout: self._timeout,
                        description: nil
                    )
                }
            }

            @objc public var toEventuallyWithDescription: (NMBMatcher, String) -> Void {
                { matcher, description in
                    self.expectValue.toEventually(
                        from(objcMatcher: matcher),
                        timeout: self._timeout,
                        description: description
                    )
                }
            }

            @objc public var toEventuallyNot: (NMBMatcher) -> Void {
                { matcher in
                    self.expectValue.toEventuallyNot(
                        from(objcMatcher: matcher),
                        timeout: self._timeout,
                        description: nil
                    )
                }
            }

            @objc public var toEventuallyNotWithDescription: (NMBMatcher, String) -> Void {
                { matcher, description in
                    self.expectValue.toEventuallyNot(
                        from(objcMatcher: matcher),
                        timeout: self._timeout,
                        description: description
                    )
                }
            }

            @objc public var toNotEventually: (NMBMatcher) -> Void {
                toEventuallyNot
            }

            @objc public var toNotEventuallyWithDescription: (NMBMatcher, String) -> Void {
                toEventuallyNotWithDescription
            }

            @objc public var toNever: (NMBMatcher) -> Void {
                { matcher in
                    self.expectValue.toNever(
                        from(objcMatcher: matcher),
                        until: self._timeout,
                        description: nil
                    )
                }
            }

            @objc public var toNeverWithDescription: (NMBMatcher, String) -> Void {
                { matcher, description in
                    self.expectValue.toNever(
                        from(objcMatcher: matcher),
                        until: self._timeout,
                        description: description
                    )
                }
            }

            @objc public var neverTo: (NMBMatcher) -> Void {
                toNever
            }

            @objc public var neverToWithDescription: (NMBMatcher, String) -> Void {
                toNeverWithDescription
            }

            @objc public var toAlways: (NMBMatcher) -> Void {
                { matcher in
                    self.expectValue.toAlways(
                        from(objcMatcher: matcher),
                        until: self._timeout,
                        description: nil
                    )
                }
            }

            @objc public var toAlwaysWithDescription: (NMBMatcher, String) -> Void {
                { matcher, description in
                    self.expectValue.toAlways(
                        from(objcMatcher: matcher),
                        until: self._timeout,
                        description: description
                    )
                }
            }

            @objc public var alwaysTo: (NMBMatcher) -> Void {
                toAlways
            }

            @objc public var alwaysToWithDescription: (NMBMatcher, String) -> Void {
                toAlwaysWithDescription
            }

            @objc public class func failWithMessage(_ message: String, file: FileString, line: UInt) {
                fail(message, location: SourceLocation(file: file, line: line))
            }
        }

    #endif

#endif // #if !os(WASI)
