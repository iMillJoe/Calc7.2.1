//
//  IMThreeDPoint.h
//  Calc7.2
//
//  Created by iMillJoe on 10/11/14.
//  Copyright (c) 2014 iMillIndustries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMThreeDPoint : NSObject

@property (nonatomic) double X, Y, Z;

-(id) initWithX: (double)X Y:(double)Y andZ:(double)Z;


-(double) deltaX_ofPoint: (IMThreeDPoint*)point;
-(double) deltaY_ofPoint: (IMThreeDPoint*)point;
-(double) deltaZ_ofPoint: (IMThreeDPoint*)point;

-(double) distanceToPoint: (IMThreeDPoint*)point;

@end
