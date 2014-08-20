//
//  SampleIntegrationTestCase.m
//  BZKIntegrationTestSuite-Demo
//
//  Created by Benoit Sarrazin on 2014-08-20.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

#import "SampleIntegrationTestCase.h"

@implementation SampleIntegrationTestCase

- (void)setUp {
    [super setUp];
    NSLog(@"[%@:%d] %@ | Thread: %@ | %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), [NSThread currentThread], @"Set Up");
}

- (void)tearDown {
    NSLog(@"[%@:%d] %@ | Thread: %@ | %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), [NSThread currentThread], @"Tear Down");
    [super tearDown];
}

- (void)testSomething {
    NSLog(@"[%@:%d] %@ | Thread: %@ | %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), [NSThread currentThread], @"Testing Something");
}

- (void)testSomethingElse {
    
    NSLog(@"[%@:%d] %@ | Thread: %@ | %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), [NSThread currentThread], @"Testing Something Else");
    
    __block BOOL success = NO;
    __block BOOL timedout = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        timedout = YES;
    });
    
    [self waitForCondition:^BOOL{
        return success || timedout;
    }
                completion:^{
                    if (NO == success)
                        self.result = BZKTestCaseResultFailed;
                }];
}

@end
