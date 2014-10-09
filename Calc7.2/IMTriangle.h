//
///  IMTriangle.h
//
//  Created by iMill Industries on 8/2/13.
/*
 < SOHCOATOA, an app for working with triangles >
 Copyright (C) <2014>  <iMill Industries>
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program. (see IMAppDelegate.h) If not, see <http://www.gnu.org/licenses/>.
 *///

#import <Foundation/Foundation.h>


@interface IMTriangle : NSObject


// The things you would expect a triangle to have
@property double sideA, sideB, sideC, angleA, angleB, angleC;
@property CGPoint pointA, pointB, pointC;

// Angle is side C is rotated from X (positive) axis, increasing in CCW direction.
// 0 deg is 3 O'Clock, 90 deg is 12 O'Clock ans so forth
@property double angleOfRotation;

// set to YES for degrees, (my preferred measure of angles)
@property BOOL shouldUseDegrees;



//init methods, initWithIMTriangle: is the designated init
-(id) initWithTriangle: (IMTriangle*) triangle;

-(id) initFromThreeSidesWithSideA: (double)sideA sideB:(double)sideB  andSideC:(double)sideC usingDegrees: (BOOL) degrees;

-(id) initFromSideAngleSideWithAngleA: (double)angleA sideB:(double)sideB  andSideC:(double)sideC usingDegrees:(BOOL)degrees;

-(id) initFromAngleSideAngleWithAngleA: (double)angleA sideB:(double)sideB andAngleC:(double)angleC usingDegrees:(BOOL)degrees;

-(id) initFromThreePointsWithPointA: (CGPoint)pointA pointB: (CGPoint)pointB andPointC: (CGPoint)pointC usingDegrees:(BOOL)degrees;



//solve method figures out the data it can from the input
-(void) solve;

//convenience methods for returning other triangle attributes.
-(double) area;
-(double) perimeter;
-(double) height;
-(double) base;
-(double) circumDiameter; // the diameter of it's circumcircle
-(CGPoint) circumCenter; // center of the circumcurcle

@end
