import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DIGreatnessTests.allTests),
        testCase(DIProviderTests.allTests),
        testCase(DIErrorsTests.allTests),
    ]
}
#endif
