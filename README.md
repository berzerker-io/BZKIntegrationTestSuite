# BZKIntegrationTestSuite

## Overview

I wrote this small library because I needed to [somewhat] automate integration testing with BLE devices which is not possible to do using unit tests. This test suite is based on (but does not inherit from) the XCTestCase class. It has the same 'kind' of functionality, including `setUp` and `tearDown` functions. It also scans your implementation file for any methods prefixed with "test" (i.e. `testSomething`, `testSomethingElse`).

## Installation using Cocoapods

```ruby
pod 'BZKIntegrationTestSuite'
```

## How to use

It should be pretty simple to figure out how to make it work from the example project.
I will eventually update this README to include better instructions.
However, here is a quick 'to do' in order to use this.

1. Create an instance of `BZKIntegrationTestCaseManager`
1. Subclass `BZKIntegrationTestCase` for every test case you want to use
1. Make sure to call `[super setUp]` and `[super tearDown]` in your subclasses.
1. Create as many test methods as you want:

    ```objective-c
    - (void)testSomething;
    - (void)testSomethingElse
    ```
    
1. Run the test cases by calling `runTests:completion:` on your instance of `BZKIntegrationTestCaseManager`
