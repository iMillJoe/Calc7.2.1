//
//  Calc7_2Tests.m
//  Calc7.2Tests
//
//  Created by Joe Million on 8/2/13.
//  Copyright (c) 2013 iMillIndustries. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IMCalculatorBrain.h"

@interface Calc7_2Tests : XCTestCase
@property (nonatomic, strong) IMCalculatorBrain* brain;

@end

@implementation Calc7_2Tests

- (void)setUp
{
    [super setUp];
    self.brain = [[IMCalculatorBrain alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    [super tearDown];
}

- (void)testExample
{
    // 3 * 2 = 6
    NSString* test = [self.brain evaluateExpression:@"3*2"];
    XCTAssertEqualObjects(test, @"6" );
    
    
    // Implcit multiplacation with π
    // 2π = 6.283185307179586
    test = [self.brain evaluateExpression:@"2π"];
    XCTAssertEqualObjects(test, @"6.283185307179586");
    test = [self.brain evaluateExpression:@"π2"];
    XCTAssertEqualObjects(test, @"6.283185307179586");
    test = [self.brain evaluateExpression:@"2(3+5)"];
    XCTAssertEqualObjects(test, @"16");
    test = [self.brain evaluateExpression:@"(3+5)2"];
    XCTAssertEqualObjects(test, @"16");
    test= [self.brain evaluateExpression:@"2*2*2"];
    XCTAssertEqualObjects(test, @"8");
    test = [self.brain evaluateExpression:@"2(3*3)+15/3"];
    XCTAssertEqualObjects(test, @"23");
    test = [self.brain evaluateExpression:@"3(4(5(6*7²)))"];
    XCTAssertEqualObjects(test, @"17640");
    
    
    
    
    
    
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
}

@end
