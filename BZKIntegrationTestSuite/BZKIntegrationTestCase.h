//
//  BZKIntegrationTestCase.h
//  BZKIntegrationTestSuite-Demo
//
//  Created by Benoit Sarrazin on 2014-08-20.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

@import Foundation;

#pragma mark - Type Definitions

/**
 *  An enumeration describing the possible test case results.
 */
typedef NS_ENUM(NSInteger, BZKTestCaseResult) {
    /**
     *  The test has passed.
     */
    BZKTestCaseResultPassed,
    /**
     *  The test has failed.
     */
    BZKTestCaseResultFailed,
    /**
     *  The test has not be executed yet.
     */
    BZKTestCaseResultNotExecuted
};

#pragma mark - Constants

/**
 *  A string description of `BZKTestCaseResult`.
 */
extern NSString * const BZKTestCaseResultDescription[];

#pragma mark - Interface

/**
 *  This class should be used as base class for all your integration tests.
 *  This subclass of `NSOperation` looks for all the methods that start with "test" and executes them.
 *  You can use the `setUp` and `tearDown` methods just like `XCTestCase` class.
 */
@interface BZKIntegrationTestCase : NSOperation

#pragma mark - Properties

/**
 *  A string that identifies this test case. It is not used internally, it is merely available for convenience.
 */
@property (nonatomic, strong) NSString *identifier;

/**
 *  A progress block called when a `test` method has completed.
 *  The index of the `test` method in the internal array of tests.
 */
@property (nonatomic, copy) void(^progress)(NSUInteger index);

#pragma mark - Set Up & Tear Down

/** @name section Set Up & Tear Down */

/**
 *  This method should set up the requirements for running each test.
 *  The `setUp` method is called once, for every test in the test case.
 */
- (void)setUp;

/**
 *  This method should destroy the requirements after running each test.
 *  The `tearDown` method is called once, for every test in the test case.
 */
- (void)tearDown;

#pragma mark - Utilities

/** @name Utilities */

/**
 *  Reports the result of a test. The result is saved and is put into a simple NSDictionary report.
 *
 *  @param result The result of the test.
 *  @param error  The error if the test failed.
 */
- (void)reportTestResult:(BZKTestCaseResult)result error:(NSError *)error;

/**
 *  Returns an NSDictionary object containing the name of all tests that have been reported.
 *  The key is the name of the test. The value is the error that was reported.
 *
 *  @return An instance of `NSDictionary` containing the test names and their associated result.
 */
- (NSDictionary *)testReport;

/**
 *  The number of test methods of this class or subclass.
 *
 *  @return An `NSUInteger` representing the number of test methods.
 */
- (NSUInteger)testCount;

/**
 *  Pauses the execution of the test until the condition is met. Once the condition is met, the completion block is executed.
 *
 *  @param condition  A block that returns a boolean value. The execution of the completion block will be held until this condition returns `YES`.
 *  @param completion The completion block is executed once the condition block return `YES`.
 */
- (void)waitForCondition:(BOOL(^)(void))condition completion:(void(^)(void))completion;

@end
