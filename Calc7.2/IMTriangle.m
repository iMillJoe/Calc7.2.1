//
//  IMTriangle.m
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

#import "IMTriangle.h"


//private declarations
@interface IMTriangle()
@property BOOL solved; //Is this triangle solved completely?
@property NSString *error; //Error message 
@end

@implementation IMTriangle

@synthesize sideA                       =_sideA;
@synthesize sideB                       =_sideB;
@synthesize sideC                       =_sideC;
@synthesize angleA                      =_angleA;
@synthesize angleB                      =_angleB;
@synthesize angleC                      =_angleC;
@synthesize shouldUseDegrees            =_shouldUseDegrees;
@synthesize angleOfRotation             =_angleOfRotation;
@synthesize solved                      =_solved;
@synthesize error                       =_error;



//Find a way to make sure that any part of the triangle, I don't currently know, but wish too, is calculated, when AND ONLY WHEN, it is needed at runtime

//****** TO DO ***** 
//Warn user if an side/angle that is being set, does not jive with other data entered.

#pragma mark init methods

-(id) initWithTriangle:(IMTriangle *)triangle
{
    if (self = [super init])
    {
        if (triangle.solved == YES)
        {
          self = triangle;
        }
        else
        {
            [triangle solve];
            if (triangle.solved == YES)
            {
                self = triangle;
            }
            else return nil;
        }
        return self;
    }
    NSLog(@"initWithTriangle: failed");
    return nil;
    
}

-(id) initFromThreeSidesWithSideA: (double)sideA sideB:(double)sideB  andSideC:(double)sideC usingDegrees: (BOOL)degrees;
{
    if (degrees) _shouldUseDegrees = YES;
    if (!(_sideA && _sideB && _sideC))
    {
        self.sideA = sideA , self.sideB = sideB , self.sideC = sideC;
        [self solve];
    }
    else NSLog(@"initFromThreeSides triangle already exisits");
    if (self.solved)
    {
        return [self initWithTriangle:self];
    }
    else
    {
        NSLog(@"initFromThreeSides: failed");
        return nil;
    }
}

-(id) initFromSideAngleSideWithAngleA: (double)angleA sideB:(double)sideB  andSideC:(double) sideC usingDegrees:(BOOL)degrees;
{
    if (degrees) _shouldUseDegrees = YES;
    if (!(self.sideA && self.sideB && self.sideC))
    {
        self.angleA = angleA , self.sideB = sideB , self.sideC = sideC;
        [self solve];
    }
    else NSLog(@"initFromSideAngleSide: failed, triangle already exisits");
    if (self.solved) {
        return [self initWithTriangle: self];
    }
    else
    {
        NSLog(@"initFromSideAngleSide: failed");
        return nil;
    }
}

-(id) initFromAngleSideAngleWithAngleA: (double)angleA sideB:(double)sideB andAngleC:(double)angleC usingDegrees:(BOOL)degrees;
{
    if (degrees) _shouldUseDegrees = YES;
    if (!(self.angleA && _sideB && self.angleC))
    {
        self.angleA = angleA , self.sideB = sideB , self.angleC = angleC;
        [self solve];
    }
    else NSLog(@"initFromAngleSideAngle: failed, triangle already exists");
    if (self.solved) {
        return [self initWithTriangle: self];
    }
    else
    {
        NSLog(@"initFromAngleSideAngle: failed");
        return nil;
    }
}


#pragma mark solve

-(void) solve
{
    bool shouldOutputDegrees = NO;
    if (self.shouldUseDegrees)
    {
        self.shouldUseDegrees = NO;
        shouldOutputDegrees = YES;
    }

    if (self.sideA && self.sideB && self.sideC)
    {
        //If the any one leg is longer than the sum of of the other two, it's not a traingle.
        if ( (self.sideA > self.sideB + self.sideC) || (self.sideB > self.sideC + self.sideA) || (self.sideC > self.sideB + self.sideA) )
        {
            self.error = @"not a triangle";
        }
        
        //If the triangle has Three sides, find it's angles,
        self.angleA = acos(  ((self.sideB*self.sideB)+(self.sideC*self.sideC) - (self.sideA*self.sideA))/(2*self.sideB*self.sideC)  );
        self.angleB = acos(  ((self.sideC*self.sideC)+(self.sideA*self.sideA) - (self.sideB*self.sideB))/(2*self.sideC*self.sideA)  );
        self.angleC = M_PI - self.angleA - self.angleB;
    }
    
    else if (self.angleA && self.sideB && self.angleC)
    {
        //Solve with AsA for AbC
        self.angleB = M_PI - self.angleA - self.angleC;
        self.sideC = (self.sideB * sin(self.angleC))/ sin(self.angleB);
        self.sideA = (self.sideB * sin(self.angleA))/ sin(self.angleB);
    }
    
    else if (self.angleB && self.sideC && self.angleA)
    {
        //solve with ASA for BcA
        self.angleC = M_PI - self.angleB - self.angleA;
        self.sideA = (self.sideC * sin(self.angleA))/ sin(self.angleC);
        self.sideB = (self.sideC * sin(self.angleB))/ sin(self.angleC);
        
    }
    
    else if (self.angleC && self.sideA && self.angleB)
    {
        //solve with ASA for CaB
        self.angleA = M_PI - self.angleC - self.angleB;
        self.sideB = (self.sideA * sin(self.angleB))/ sin(self.angleA);
        self.sideC = (self.sideA * sin(self.angleC))/ sin(self.angleA);
        
    }
    
    else if (self.angleA && self.sideB && self.sideC)
    { 
        //solve by SAS for Abc 
        //law of cos for c
        //a² = b² + c² - 2bc cosA
        self.sideC = sqrt(  (self.sideB*self.sideB)+(self.sideC*self.sideC) - ((2*self.sideB*self.sideC) * ( cos(self.angleA) ))  );
        
        //law of sin for B
        self.angleB = (  asin( ( self.sideB * (sin(self.angleA)) )/ self.sideA)  );
        self.angleC = M_PI - self.angleB - self.angleA;
    }
    
    else if (self.angleC && self.sideA && self.sideB)
    {
        //solve by SAS for Cab
         self.sideC = sqrt(  (self.sideA*self.sideA)+(self.sideB*self.sideB) - (2 *self.sideA*self.sideB) * ( cos(self.angleC) )  );
        self.angleA = (  asin( ( self.sideA * (sin(self.angleC)) )/ self.sideC)  );
        self.angleB = M_PI - self.angleC - self.angleA;
        
    }
    
    else if (self.angleB && self.sideA && self.sideC)
    {
        //solve with SAS for Bac
        self.sideB = sqrt(  (self.sideA*self.sideA)+(self.sideC*self.sideC) - (2 *self.sideA*self.sideC) * ( cos(self.angleB) )  );
        self.angleC = (  asin( ( self.sideA * (sin(self.angleB)) )/ self.sideB)  );
        self.angleA = M_PI - self.angleC - self.angleB;
    }

    else if ( (self.angleA && self.angleB) || (self.angleB && self.angleC) || (self.angleC && self.angleA) )
    {
        //solve for AAA, Note that this cannot solve for sides area or perimeter.
        if (self.angleA && self.angleB)
        {
            self.angleC = M_PI - self.angleA - self.angleB;
        }
        
        else if (self.angleB && self.angleC)
        {
            self.angleA = M_PI - self.angleB - self.angleC;
        }
        
        else if (self.angleB && self.angleC)
        {
            self.angleA = M_PI - self.angleB - self.angleC;
        }
        
        else NSLog(@"failed to solve AAA");
    }
    
    else
    {
        self.error = @"Could not parse IMTriangle";
        NSLog(@"%@",self.error);
    }
    
    
    self.shouldUseDegrees = shouldOutputDegrees;

    if (self.sideA && self.sideB && self.sideC && self.angleA && self.angleB && self.angleC && !self.error)
    {
        self.solved = YES;
    }
}

#pragma mark setters and getters

-(void) setAngleA:(double)angleA
{
    if (!self.shouldUseDegrees)
    {
        _angleA = angleA;
    }
    
    else _angleA = angleA * M_PI/180;
    
    //should I set the error and return first? 
    if  (angleA > M_PI && !self.shouldUseDegrees)
    {
        self.error = @"Not a triangle, angleA is greater than Pi";
    }
    
    if (angleA > 180 && self.shouldUseDegrees)
    {
        self.error = @"Not a triangle, angleA is greater than 180 deg";
    }
}

-(double) angleA
{
    if (!self.shouldUseDegrees)
    {
        return _angleA;
    }
    return  _angleA * 180/M_PI;
}

-(void) setAngleB:(double)angleB
{
    if (!self.shouldUseDegrees)
    {
        _angleB = angleB;
    }
    else _angleB = angleB * M_PI/180;
    
    if  (angleB > M_PI && !self.shouldUseDegrees)
    {
        self.error = @"Not a triangle, angleB is greater than Pi";
    }
    else if (angleB > 180 && _shouldUseDegrees)
    {
        self.error = @"Not a triangle, angleB is greater than 180 deg";
    }
}

-(double) angleB
{
    if (!self.shouldUseDegrees)
    {
        return _angleB;
    }
    return  _angleB * 180/M_PI;
}

-(void) setAngleC:(double)angleC
{
    if (!self.shouldUseDegrees)
    {
        _angleC = angleC;
    }
    else _angleC = angleC * M_PI/180;
    
    if  (angleC > M_PI && !self.shouldUseDegrees)
    {
        self.error = @"Not a triangle, angleC is greater than Pi";
    }
    if (angleC > 180 && self.shouldUseDegrees)
    {
        self.error = @"Not a triangle, angleC is greater than 180 deg";
    }
}

-(double) angleC
{
    if (!self.shouldUseDegrees)
    {
        return _angleC;
    }
    return _angleC * 180/M_PI;
}

-(void) setAngleOfRotation:(double)angleOfRotation
{
    if (!self.shouldUseDegrees){
        _angleOfRotation = angleOfRotation;

    }
    else _angleOfRotation =angleOfRotation * M_PI/180;
    
    if  (angleOfRotation > M_PI*2 && !self.shouldUseDegrees)
    {
        self.error = @"angleOfRotation is greater than 2Pi";
    }
    if (angleOfRotation > 180 && self.shouldUseDegrees)
    {
        self.error = @"angleOfRotation is greater than 360 deg";
    }
}

-(double) angleOfRotation
{
    if (!self.shouldUseDegrees) {
        return self.angleOfRotation;
    }
    return  _angleOfRotation * 180/M_PI;
}

#pragma mark convenience methods

-(double) height
{
    if (self.sideA && self.sideB && self.sideC)
    {
        return self.sideB*( sin(self.angleA) );
    }
	else return 0; 
}

-(double) perimeter
{
    if (self.sideA && self.sideB && self.sideC)
    {
        return self.sideA + self.sideB + self.sideC;
    }
    else return 0;
}

-(double) area
{
    if (self.sideA && self.sideB && self.sideC)
    {
        double x = self.perimeter/2; //x is half the sum of the sides
        return self.sideA * (2/self.sideA) * sqrt(x*(x-self.sideA)*(x-self.sideB)*(x-self.sideC)) / 2;//Heron's formula for area
    }
    else return 0;
}

-(double) base
{
    return self.sideC;
}


-(NSString *) description;
{
    if (self.error)
    {
        return [NSString stringWithFormat:@"error %@ a=%.4f b=%.4f c=%.4f A=%.4f B=%.4f C=%.4f perimeter=%.4f area=%.4f height=%.4f shouldUseDegrees = %i", self.error, self.sideA , self.sideB , self.sideC , self.angleA , self.angleB , self.angleC ,self.perimeter , self.area ,  self.height , self.shouldUseDegrees];
        
    }
    else return [NSString stringWithFormat:@"a=%.4f b=%.4f c=%.4f A=%.4f B=%.4f C=%.4f perimeter=%.4f area=%.4f height=%.4f shouldUseDegrees = %i", self.sideA , self.sideB , self.sideC , self.angleA , self.angleB , self.angleC , self.perimeter , self.area ,  self.height , self.shouldUseDegrees];
    
}

@end