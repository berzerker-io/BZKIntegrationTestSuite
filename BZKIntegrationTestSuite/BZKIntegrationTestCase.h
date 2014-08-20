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
    BZKTestCaseResultFailed
};

#pragma mark - Constants

/**
 *  A string description of `BZKTestCaseResult`.
 */
extern NSString * const BZKTestCaseResultDescription[];

#pragma mark - Interface

/**
 *  This class should be used as base class for all your integration tests.
 *  This sublass of `NSOperation` looks for all the methods that start with "test" and executes them.
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

/**
 *  The result of the test case. The default is `BZKTestCaseResultPassed`.
 *  You should set this value at the end of each `test` method.
 *  Once the value has been set to `BZKTestCaseResultFailed`, it cannot be set back to `BZKTestCaseResultPassed`.
 */
@property (nonatomic, assign) BZKTestCaseResult result;

/**
 *  The name of the first `test` method that failed. Helpful for idenfying where the test case failed.
 */
@property (nonatomic, strong) NSString *firstFailedMethodName;

#pragma mark - Set Up & Tear Down

/** @name section Set Up & Tear Down */

/**
 *  This method should set up the requirements for running all the tests.
 *  The `setUp` method is called once, then all the `test` methods are executed.
 */
- (void)setUp;

/**
 *  This method should destroy the requirements after running all the tests.
 *  The `tearDown` method is called once, after all the `test methods have been executed.
 */
- (void)tearDown;

#pragma mark - Utilities

/** @name Utilities */

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
