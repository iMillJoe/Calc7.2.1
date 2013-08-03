//
//  TriangleDrawVeiw.m
//  Triangle Calculator
//
//  Created by Joseph Million on 5/12/12.
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
//

#import "TriangleDrawVeiw.h"


@implementation TriangleDrawVeiw

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


#define LINE_WIDTH 3.0


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

    CGContextSetLineWidth(ctx, LINE_WIDTH);
    [[UIColor blackColor] setStroke];

    //plot it's path
    CGContextMoveToPoint (ctx, pointA.x, pointA.y);
    CGContextAddLineToPoint(ctx, pointB.x, pointB .y);
    CGContextAddLineToPoint(ctx, pointC.x, pointC.y);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);

 
}


@end
