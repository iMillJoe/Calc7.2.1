//
//  IMThreeDPoint.m
//  Calc7.2
//
//  Created by iMillJoe on 10/11/14.
//  Copyright (c) 2014 iMillIndustries. All rights reserved.
//

#import "IMThreeDPoint.h"


//private declarations
@interface IMThreeDPoint()
@property NSString *error; //Error message?
@end

@implementation IMThreeDPoint

-(id) initWithX:(double)X Y:(double)Y andZ:(double)Z
{
    self = [super init];
    if (self)
    {
        _X = X;
        _Y = Y;
        _Z = Z;
        return self;
    }
    return nil;
}

-(id) init
{
    return [self initWithX:0 Y:0 andZ:0];
}

-(double) deltaX_ofPoint: (IMThreeDPoint*)point
{

    return fabs(self.X - point.X);
}

-(double) deltaY_ofPoint: (IMThreeDPoint*)point
{

    return fabs(self.Y - point.Y);
}

-(double) deltaZ_ofPoint: (IMThreeDPoint*)point
{
    return fabs(self.Z - point.Z);
}

-(double) distanceToPoint:(IMThreeDPoint *)point
{
    return sqrt(  ([self deltaX_ofPoint:point] * [self deltaX_ofPoint:point])
                + ([self deltaY_ofPoint:point] * [self deltaY_ofPoint:point])
                + ([self deltaZ_ofPoint:point] * [self deltaZ_ofPoint:point]) );
}

@end
