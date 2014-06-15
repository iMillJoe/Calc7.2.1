//
//  IMTriangleDrawVeiw.m
//  Triangle Calculator
//
//  Created by iMill Industries on 5/12/12.
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

#import "IMTriangleDrawVeiw.h"


@implementation IMTriangleDrawVeiw

@synthesize dataSource = _dataSource;



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
    IMTriangle *triangle = [self.dataSource triangle];
    if (!triangle) return;
    triangle.shouldUseDegrees = NO;
    NSLog(@"incoming triangle %@", triangle);
    IMTriangle *drawTri = [[IMTriangle alloc] init];
    drawTri.shouldUseDegrees = NO;
    
    CGRect bounds = [self bounds];
    
    /*Find point A and B, 
     pointA is the lower left side, pointB is the lower right side*/
    CGPoint pointA = CGPointMake(  bounds.origin.x + bounds.size.width * .05 , bounds.origin.y+bounds.size.height - bounds.size.height*.05  );
    CGPoint pointB = CGPointMake(  bounds.origin.x + bounds.size.width * .95 , bounds.origin.y+bounds.size.height - bounds.size.height*.05  );
    
    //find the distance between Point A and B, (sideC)
    CGFloat c = pointB.x - pointA.x;
    NSLog(@"side c display length = %f" , c);
    NSLog(@"point A = %f, %f, point B = %f, %f", pointA.x, pointA.y, pointB.x ,pointB.y);
    
    //use distance from of the new side C and the angles of the passed in triangle to find pointC
    drawTri.sideC = c;
    drawTri.angleA = triangle.angleA;
    drawTri.angleB = triangle.angleB;
    [drawTri solve];
    
    NSLog(@"drawTri %@" , drawTri);
    CGPoint pointC = CGPointMake( (pointA.x + (drawTri.sideB * cos(drawTri.angleA )) ) , (pointA.y - ([drawTri height] ) ));
    
    /*****************************************************************************************************/
    //THIS SEEMS LIKE THE APROPRIATE POINT TO SCALE THE TRIANGLE (AGAIN) IF IT IT WILL EXCEED IT'S BOUNDS//
    /*****************************************************************************************************/
    
    if (pointC.x - pointB.x > drawTri.sideC) {
        //do something, 
    }
    else if (pointB.x - pointA.x > drawTri.sideC)
    {
        //do something else. 
    }
    
    
    //Draw the triangle. 
    
    //get the currant drawing context, 
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(ctx, 3);
    [[UIColor blackColor] setStroke];

    //plot it's path
    CGContextMoveToPoint (ctx, pointA.x, pointA.y);
    CGContextAddLineToPoint(ctx, pointB.x, pointB .y);
    CGContextAddLineToPoint(ctx, pointC.x, pointC.y);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);

 
}


@end
