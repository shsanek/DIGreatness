import XCTest

import DIGreatnessTests

private var tests = [XCTestCaseEntry]()

tests += DIGreatnessTests.allTests()
tests += DIProviderTests.allTests()

XCTMain(tests)
