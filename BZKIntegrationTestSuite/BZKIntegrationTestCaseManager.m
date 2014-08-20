//
//  BZKIntegrationTestCaseManager.m
//  BZKIntegrationTestSuite-Demo
//
//  Created by Benoit Sarrazin on 2014-08-20.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

#import "BZKIntegrationTestCaseManager.h"

#pragma mark - Class Extension

@interface BZKIntegrationTestCaseManager ()

#pragma mark - Private Properties

/**
 *  The private operation queue on which the test cases will be performed.
 */
@property (nonatomic, strong) NSOperationQueue *queue;

/**
 *  The number of completed test cases.
 */
@property (nonatomic, assign) NSInteger nbCompletedOperations;

@end

#pragma mark - Implementation

@implementation BZKIntegrationTestCaseManager

#pragma mark - Initialization

- (id)init {
    self = [super init];
    if (nil != self) {
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

#pragma mark - Running Tests

- (void)runTests:(NSArray *)tests completion:(void (^)(NSArray *))completion {
    for (BZKIntegrationTestCase *test in tests) {
        void (^completionBlock)(void) = test.completionBlock;
        test.completionBlock = ^void(void) {
            if (completionBlock)
                completionBlock();
            
            self.nbCompletedOperations += 1;
            if (self.nbCompletedOperations >= tests.count)
                if (completion)
                    completion(tests);
        };
    }
    
    [self.queue addOperations:tests waitUntilFinished:NO];
}

@end
