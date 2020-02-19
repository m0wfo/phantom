import XCTest

import phantomTests

var tests = [XCTestCaseEntry]()
tests += phantomTests.allTests()
XCTMain(tests)
