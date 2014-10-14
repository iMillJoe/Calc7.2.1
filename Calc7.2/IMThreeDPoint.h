//
//  IMThreeDPoint.h
//  Calc7.2
//
//  Created by Joe Million on 10/11/14.
//  Copyright (c) 2014 iMillIndustries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMThreeDPoint : NSObject

@property (nonatomic) double X, Y, Z;

-(double) deltaX_ofPointA: (IMThreeDPoint*)pointA andPointB: (IMThreeDPoint*)pointB;
-(double) deltaY_ofPointA: (IMThreeDPoint*)pointA andPointB: (IMThreeDPoint*)pointB;
-(double) deltaZ_ofPointA: (IMThreeDPoint*)pointA andPointB: (IMThreeDPoint*)pointB;

@end
