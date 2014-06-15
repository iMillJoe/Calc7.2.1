//
//  IMCircumcircleDrawView.m
//  Calc7.2
//
//  Created by iMill Industries on 3/24/14.
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
//

#import "IMCircumcircleDrawView.h"

@implementation IMCircumcircleDrawView

-(void) setup
{
    self.contentMode = UIViewContentModeRedraw;
    
}

-(void) awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    
    
    NSLog(@"Horray My DrawRect Got Called!!!! ");
    NSLog(@"%@",self.dataSource);
    
    IMTriangle *triangle = [self.dataSource triangle];
    if (!triangle) return;
    
    triangle.shouldUseDegrees = NO;
    
    NSLog(@"incoming triangle %@", triangle);
    NSLog(@"CircumCenter X: %f Y: %f" , triangle.circumCenter.x, triangle.circumCenter.y );
    
    
    triangle.shouldUseDegrees = NO;
    
    
    float x = (self.bounds.size.width + self.bounds.origin.x) / 2;
    float y = (self.bounds.size.height + self.bounds.origin.y) / 2;
    
    
    CGPoint center = CGPointMake(x, y);
    
    
    double maxRadius = MIN(self.bounds.size.height, self.bounds.size.width);
    double circumRad = [triangle circumDiameter] / 2;
    maxRadius *= .9 * .5;
    double scaleFactor = maxRadius / circumRad;
    
    
    NSLog(@"maxRadius: %f, circumRad: %f, scaleFactor: %f", maxRadius, circumRad, scaleFactor);

    
    CGPoint pointA = CGPointMake(triangle.pointA.x * scaleFactor, triangle.pointA.y * scaleFactor);
    CGPoint pointB = CGPointMake(triangle.pointB.x * scaleFactor, triangle.pointB.y * scaleFactor);
    CGPoint pointC = CGPointMake(triangle.pointC.x * scaleFactor, triangle.pointC.y * scaleFactor);
    
    IMTriangle* newTri = [[IMTriangle alloc] initFromThreePointsWithPointA:pointA pointB:pointB andPointC:pointC usingDegrees:YES];
    
    NSLog(@"NewTraingle: %@", newTri);
    
    CGPoint cartesianOrigin = CGPointMake(center.x - newTri.circumCenter.x, center.y + newTri.circumCenter.y);
    
    pointA.x = cartesianOrigin.x + newTri.pointA.x;
    pointA.y = cartesianOrigin.y - newTri.pointA.y;
    
    pointB.x = cartesianOrigin.x + newTri.pointB.x;
    pointB.y = cartesianOrigin.y - newTri.pointB.y;
    
    pointC.x = cartesianOrigin.x + newTri.pointC.x;
    pointC.y = cartesianOrigin.y - newTri.pointC.y;
    
    //get the current drawing context,
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //draw circle
    CGContextAddArc(ctx, center.x, center.y, maxRadius, 0, 2 * M_PI, 1);
    
    //draw its center point
    CGContextMoveToPoint(ctx, center.x - 5, center.y);
    CGContextAddLineToPoint(ctx, center.x + 5, center.y);
    CGContextMoveToPoint(ctx, center.x, center.y - 5);
    CGContextAddLineToPoint(ctx, center.x, center.y + 5);
    
    //draw the triangle.
    CGContextMoveToPoint(ctx, pointA.x, pointA.y);
    CGContextAddLineToPoint(ctx, pointB.x, pointB.y);
    CGContextAddLineToPoint(ctx, pointC.x, pointC.y);
    CGContextClosePath(ctx);
    
    //If possable draw the cartesianOrigin
    if (CGRectContainsPoint(rect, cartesianOrigin))
    {
        NSLog(@"Origin Was Drawn");
        CGContextMoveToPoint(ctx, cartesianOrigin.x - 7, cartesianOrigin.y);
        CGContextAddLineToPoint(ctx, cartesianOrigin.x + 7 , cartesianOrigin.y);
        CGContextMoveToPoint(ctx, cartesianOrigin.x, cartesianOrigin.y + 7);
        CGContextAddLineToPoint(ctx, cartesianOrigin.x, cartesianOrigin.y - 7);
        CGContextMoveToPoint(ctx, cartesianOrigin.x + 7, cartesianOrigin.y);
        
        CGContextAddArc(ctx, cartesianOrigin.x, cartesianOrigin.y, 7, 0, (M_PI * 2), YES);
        
    } else {
        NSLog(@"Origin was NOT drawn");
    }
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 1);
    
    //plot it's path
    CGContextStrokePath(ctx);
    
    
    
}



@end
