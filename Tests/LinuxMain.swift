import XCTest

import DIGreatnessTests

var tests = [XCTestCaseEntry]()
tests += DIGreatnessTests.allTests()
tests += DIProviderTests.allTests()
XCTMain(tests)
