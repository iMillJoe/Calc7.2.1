//
//  IMTriCalcViewController.m
//  Triangle Calculator
//
//  Created by iMill Industries on 4/28/12.
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

#import "IMTriCalcViewController.h"



@interface IMTriCalcViewController () <IMTriangleDrawViewDataSource>

@end


@implementation IMTriCalcViewController
@synthesize textVeiwSideA = _textVeiwSideA;
@synthesize textVeiwSideB = _textVeiwSideB;
@synthesize textVeiwSideC = _textVeiwSideC;
@synthesize AngleATextFeild = _AngleATextFeild;
@synthesize AngleBTextFeild = _AngleBTextFeild;
@synthesize AngleCTextFeild = _AngleCTextFeild;
@synthesize triDisplay = _triDisplay;
@synthesize triangle = _triangle;



- (IBAction)solvedPressed:(id)sender {
    
    if (!self.triangle) {
        self.triangle = [[IMTriangle alloc] init];
        self.triangle.shouldUseDegrees = YES;
    }
    
    self.triangle.sideA  = [[self.textVeiwSideA text] doubleValue];
    self.triangle.sideB  = [[self.textVeiwSideB text] doubleValue];
    self.triangle.sideC  = [[self.textVeiwSideC text] doubleValue];
    self.triangle.angleA = [[self.AngleATextFeild text] doubleValue];
    self.triangle.angleB = [[self.AngleBTextFeild text] doubleValue];
    self.triangle.angleC = [[self.AngleCTextFeild text] doubleValue];
    [self.triangle solve];

    self.triDisplay.dataSource = self;
    [self.triDisplay setNeedsDisplay];
    [[self view] endEditing:YES];
    

    [self updateAll];
    [self.textVeiwSideA setEnabled:NO];
    [self.textVeiwSideB setEnabled:NO];
    [self.textVeiwSideC setEnabled:NO];
    [self.AngleATextFeild setEnabled:NO];
    [self.AngleBTextFeild setEnabled:NO];
    [self.AngleCTextFeild setEnabled:NO];
    
}


- (IBAction)clearPressed:(id)sender {
    
    self.textVeiwSideA.text = @"";
    self.textVeiwSideB.text = @"";
    self.textVeiwSideC.text = @"";
    self.AngleATextFeild.text = @"";
    self.AngleBTextFeild.text = @"";
    self.AngleCTextFeild.text = @"";
    self.triangle = nil;
    self.triDisplay.dataSource = nil; 
    [self.triDisplay setNeedsDisplay];
    [self.textVeiwSideA setEnabled:YES];
    [self.textVeiwSideB setEnabled:YES];
    [self.textVeiwSideC setEnabled:YES];
    [self.AngleATextFeild setEnabled:YES];
    [self.AngleBTextFeild setEnabled:YES];
    [self.AngleCTextFeild setEnabled:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{

    [self updateAll];    
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)viewDidUnload
{

    self.textVeiwSideA = nil;
    self.textVeiwSideB = nil;
    self.textVeiwSideC = nil;
    self.AngleATextFeild = nil;
    self.AngleBTextFeild = nil;
    self.AngleCTextFeild = nil;

    [self setTriDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

-(void) updateAll
{
    [self.AngleATextFeild setText: [NSString stringWithFormat:@"%.4f", self.triangle.angleA]];
    [self.AngleBTextFeild setText: [NSString stringWithFormat:@"%.4f", self.triangle.angleB]];
    [self.AngleCTextFeild setText: [NSString stringWithFormat:@"%.4f", self.triangle.angleC]];
    [self.textVeiwSideA setText:[NSString stringWithFormat:@"%.4f", self.triangle.sideA]];
    [self.textVeiwSideB setText:[NSString stringWithFormat:@"%.4f", self.triangle.sideB]];
    [self.textVeiwSideC setText:[NSString stringWithFormat:@"%.4f", self.triangle.sideC]];
    
}




@end
