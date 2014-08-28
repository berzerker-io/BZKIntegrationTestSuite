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
    NSLog(@"[%@:%d] %@ | %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), @"Set Up");
}

- (void)tearDown {
    NSLog(@"[%@:%d] %@ | %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), @"Tear Down");
}

- (void)testSomething {
    [self reportTestResult:BZKTestCaseResultPassed error:nil];
}

- (void)testSomethingElse {
    __block BOOL success = NO;
    __block BOOL timedout = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        timedout = YES;
    });
    
    [self waitForCondition:^BOOL{
        return success || timedout;
    }
                completion:^{
                    
                    if (timedout) {
                        NSError *error = [[NSError alloc] initWithDomain:NSStringFromClass(self.class) code:1 userInfo:@{NSLocalizedDescriptionKey: @"The test has timed out."}];
                        [self reportTestResult:BZKTestCaseResultFailed error:error];
                        return;
                    }
                    
                    if (success) {
                        [self reportTestResult:BZKTestCaseResultPassed error:nil];
                    }
                }];
}

@end
