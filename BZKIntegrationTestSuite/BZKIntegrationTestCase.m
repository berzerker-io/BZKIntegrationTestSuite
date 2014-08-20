//
//  BZKIntegrationTestCase.m
//  BZKIntegrationTestSuite-Demo
//
//  Created by Benoit Sarrazin on 2014-08-20.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

#import "BZKIntegrationTestCase.h"
#import <objc/runtime.h>

#pragma mark - Constants

NSString * const BZKTestCaseResultDescription[] = {
    [BZKTestCaseResultPassed] = @"Passed",
    [BZKTestCaseResultFailed] = @"Failed"
};

NSString * const BZKIntegrationTestCasePrefix = @"test";

#pragma mark - Class Extension

@interface BZKIntegrationTestCase ()

/**
 *  An internal array that contains the names, as strings, of all the `test` methods.
 */
@property (nonatomic, strong) NSMutableArray *tests;

#pragma mark - Utilities

- (void)_gatherTests;

@end

#pragma mark - Implementation

@implementation BZKIntegrationTestCase

#pragma mark - Getters & Setters

- (void)setResult:(BZKTestCaseResult)result {
    if (_result == BZKTestCaseResultPassed)
        _result = result;
}

- (void)setFirstFailedMethodName:(NSString *)firstFailedMethodName {
    if (_firstFailedMethodName)
        return;
    
    _firstFailedMethodName = firstFailedMethodName;
}

#pragma mark - Set Up & Tear Down

- (void)setUp {
    [self _gatherTests];
    self.result = BZKTestCaseResultPassed;
}

- (void)tearDown {
    self.tests = nil;
}

#pragma mark - Execution

- (void)main
{
    @autoreleasepool {
        
        if (self.isCancelled)
            return;
        
        [self setUp];
        
        if (self.isCancelled) {
            [self tearDown];
            return;
        }
        
        for (NSString *testName in self.tests) {
            if (self.isCancelled) {
                [self tearDown];
                return;
            }
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            SEL selector = NSSelectorFromString(testName);
            [self performSelector:selector];
#pragma clang diagnostic pop
            
            if (self.isCancelled) {
                [self tearDown];
                return;
            }
            
            if (self.progress)
                self.progress([self.tests indexOfObject:testName]);
            
            if (self.isCancelled) {
                [self tearDown];
                return;
            }
        }
        
        [self tearDown];
    }
}

#pragma mark - Utilities

- (NSUInteger)testCount {
    NSUInteger nbTests = self.tests.count;
    return nbTests;
}

- (void)waitForCondition:(BOOL(^)(void))condition completion:(void(^)(void))completion {
    if (condition)
        while (!condition())
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    
    if (completion)
        completion();
}

- (void)_gatherTests {
    int unsigned nbMethods;
    Method *methods = class_copyMethodList(self.class, &nbMethods);
    for (int i = 0; i < nbMethods; i++) {
        NSString *methodName = NSStringFromSelector(method_getName(methods[i]));
        if ([methodName hasPrefix:BZKIntegrationTestCasePrefix]) {
            if (nil == self.tests)
                self.tests = [@[] mutableCopy];
            
            [self.tests addObject:methodName];
        }
    }
}

@end
