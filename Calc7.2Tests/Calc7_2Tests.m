//
//  Calc7_2Tests.m
//  Calc7.2Tests
//
//  Created by Joe Million on 8/2/13.
//  Copyright (c) 2013 iMillIndustries. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IMCalculatorBrain.h"
#import "IMThreeDPoint.h"

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
    
    NSString* test;
    test = [self.brain evaluateExpression:@"3*2"];
    XCTAssertEqualObjects(test, @"6" );
    
    test = [self.brain evaluateExpression:@"2π"];
    XCTAssertEqualObjects(test, @"6.283185307179586");
    
    test = [self.brain evaluateExpression:@"π2"];
    XCTAssertEqualObjects(test, @"6.283185307179586");
    
    test = [self.brain evaluateExpression:@"π²+π3((13π/π12))"];
    XCTAssertEqualObjects(test, @"1480.134966281113");
    
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
    
    test = [self.brain evaluateExpression:@"3((4*5)(5-1))²"];
    XCTAssertEqualObjects(test, @"19200");
    
    test = [self.brain evaluateExpression:@"3+2²(π5π/3(SIN30)9*12)+2"];
    XCTAssertEqualObjects(test, @"3558.057584392167");
    
    test = [self.brain evaluateExpression:@"2.3*4.53((π²9)"];
    XCTAssertEqualObjects(test, @"extra '(' ");
     
    test = [self.brain evaluateExpression:@"2.3*4.5.3(π²9)"];
    XCTAssertEqualObjects(test, @"syntaxError");
    
    test = [self.brain evaluateExpression:@"2(SIN 30)"];
    XCTAssertEqualObjects(test, @"0.9999999999999999");
    
    test = [self.brain evaluateExpression:@"2(SIM 30)"];
    XCTAssertEqualObjects(test, @"SIN error");
    
    test = [self.brain evaluateExpression:@"(14.378)π9(12.3).32"];
    XCTAssertEqualObjects(test, @"1600.095674395477");
    
    test = [self.brain evaluateExpression:@"2-.5"];
    XCTAssertEqualObjects(test, @"1.5");
    
    test = [self.brain evaluateExpression:@"2.-.5"];
    XCTAssertEqualObjects(test, @"1.5");
    
    test = [self.brain evaluateExpression:@"2.0-0.5"];
    XCTAssertEqualObjects(test, @"1.5");
    
    IMThreeDPoint* pointA = [[IMThreeDPoint alloc] initWithX: 2.3 Y: 3.4 andZ: .01];
    IMThreeDPoint* pointB = [[IMThreeDPoint alloc] initWithX: 3.4 Y: 4.6 andZ: -.01];
    XCTAssertEqual([pointA deltaX_ofPoint: pointB], 1.1);
    XCTAssertEqual([pointA deltaY_ofPoint:pointB], 1.2);
    XCTAssertEqual([pointA distanceToPoint:pointB], 1.628004914);
    
    
    
}

@end
