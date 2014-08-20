//
//  BZKIntegrationTestCaseManager.h
//  BZKIntegrationTestSuite-Demo
//
//  Created by Benoit Sarrazin on 2014-08-20.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

@import Foundation;

#import "BZKIntegrationTestCase.h"

#pragma mark - Interface

@interface BZKIntegrationTestCaseManager : NSObject

#pragma mark - Running Tests

/** @name Running Tests */

/**
 *  Runs the tests on a private `NSOperationQueue`.
 *
 *  @param tests      An array of `BZKIntegrationTestCase` objects.
 *  @param completion A completion block that will be executed once all the test cases have completed.
 */
- (void)runTests:(NSArray *)tests completion:(void(^)(NSArray *tests))completion;

@end
