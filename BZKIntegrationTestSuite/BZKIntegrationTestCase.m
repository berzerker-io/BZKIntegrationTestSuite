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
    [BZKTestCaseResultFailed] = @"Failed",
    [BZKTestCaseResultNotExecuted] = @"Not Executed"
};

NSString * const BZKIntegrationTestCasePrefix = @"test";

#pragma mark - Class Extension

@interface BZKIntegrationTestCase ()

/**
 *  The name of the test being currently executed.
 */
@property (nonatomic, strong) NSString *currentTest;

/**
 *  An internal array that contains the names, as strings, of all the `test` methods.
 */
@property (nonatomic, strong) NSMutableArray *tests;

/**
 *  An internal dictionary that contains test results.
 */
@property (nonatomic, strong) NSMutableDictionary *report;

#pragma mark - Utilities

- (void)_gatherTests;

@end

#pragma mark - Implementation

@implementation BZKIntegrationTestCase

- (id)init {
    self = [super init];
    if (nil != self) {
        [self _gatherTests];
    }
    return self;
}

#pragma mark - Set Up & Tear Down

- (void)setUp {}

- (void)tearDown {}

#pragma mark - Execution

- (void)main
{
    @autoreleasepool {
        
        if (self.isCancelled)
            return;

        for (NSString *testName in self.tests) {
            
            self.currentTest = testName;
            
            [self setUp];

            if (self.isCancelled)
                break;
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            SEL selector = NSSelectorFromString(self.currentTest);
            [self performSelector:selector];
#pragma clang diagnostic pop
            
            if (self.isCancelled)
                break;
            
            if (self.progress)
                self.progress([self.tests indexOfObject:self.currentTest]);
            
            if (self.isCancelled)
                break;

            [self tearDown];
        }

        if (self.isCancelled) {
            [self tearDown];
        }
    }
}

#pragma mark - Utilities

- (void)reportTestResult:(BZKTestCaseResult)result error:(NSError *)error {
    if (nil == self.report)
        self.report = [@{} mutableCopy];
    
    NSString *resultMessage = nil;
    switch (result) {
        case BZKTestCaseResultFailed: {
            resultMessage = [NSString stringWithFormat:@"Failure: %@", error.localizedDescription];
            break;
        }
            
        case BZKTestCaseResultPassed:
            resultMessage = @"Success";
            break;
            
        default:
            break;
    }
    
    if (self.currentTest && resultMessage) {
        self.report[self.currentTest] = resultMessage;
    }
    
}

- (NSDictionary *)testReport {
    return [self.report copy];
}

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
