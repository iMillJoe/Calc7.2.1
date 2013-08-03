//
//  IMTriangle.h
//
/*
 The MIT License (MIT)
 
 Copyright (c) 2013 Joseph Million
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <Foundation/Foundation.h>


@interface IMTriangle : NSObject



@property double sideA, sideB, sideC, angleA, angleB, angleC; //The things you would expect a triangle to have
@property double angleOfRotation; //Angle side C is rotated from X (positive) axis, increasing in CCW direction.
@property BOOL shouldUseDegrees; // set to YES for degrees, (my preferred measure of angles)
//perhaps a CGPoint for center? 


//init methods, initWithIMTriangle: is the designated init
-(id) initWithTriangle: (IMTriangle*) triangle;
-(id) initFromThreeSidesWithSideA: (double)sideA sideB:(double)sideB  andSideC:(double)sideC usingDegrees: (BOOL) degrees;
-(id) initFromSideAngleSideWithAngleA: (double)angleA sideB:(double)sideB  andSideC:(double)sideC usingDegrees:(BOOL)degrees;
-(id) initFromAngleSideAngleWithAngleA: (double)angleA sideB:(double)sideB andAngleC:(double)angleC usingDegrees:(BOOL)degrees;


//solve method figures out the data it can from the users input
-(void) solve;

//convenience methods for returning other triangle attributes.
-(double) area;
-(double) perimeter;
-(double) height;
-(double) base;

@end
