//
//  ViewController.m
//  BZKIntegrationTestSuite-Demo
//
//  Created by Benoit Sarrazin on 2014-08-20.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

#import "ViewController.h"

#import "BZKIntegrationTestSuite.h"
#import "SampleIntegrationTestCase.h"

@interface ViewController ()

@property (nonatomic, strong) BZKIntegrationTestCaseManager *manager;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[BZKIntegrationTestCaseManager alloc] init];
    
    SampleIntegrationTestCase *testCase = [[SampleIntegrationTestCase alloc] init];
    testCase.identifier = @"UNIQUEIDENTIFIER";
    
    [self.manager runTests:@[testCase]
                completion:^(NSArray *tests) {
                    NSLog(@"[%@:%d] %@ | %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), @"All Tests Completed");
                    for (BZKIntegrationTestCase *testCase in tests) {
                        NSLog(@"[%@:%d] %@ | %@: %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), testCase.identifier, testCase.testReport);
                    }
                }];
}

@end
