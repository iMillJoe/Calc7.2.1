//
//  IMTriCalcViewController.m
//  Triangle Calculator
//
//  Created by Joseph Million on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IMTriCalcViewController.h"



@interface IMTriCalcViewController () <IMTriangleDrawViewDataSource>

@end


@implementation IMTriCalcViewController
@synthesize textVeiwSideA;
@synthesize textVeiwSideB;
@synthesize textVeiwSideC;
@synthesize AngleATextFeild;
@synthesize AngleBTextFeild;
@synthesize AngleCTextFeild;
@synthesize triDisplay;
@synthesize triangle;



- (IBAction)solvedPressed:(id)sender {
    
    if (!triangle) {
        triangle = [[IMTriangle alloc] init];
        triangle.shouldUseDegrees = YES;
    }
    
    triangle.SideA  = [[textVeiwSideA text] doubleValue];
    triangle.SideB  = [[textVeiwSideB text] doubleValue];
    triangle.SideC  = [[textVeiwSideC text] doubleValue];
    triangle.angleA = [[AngleATextFeild text] doubleValue];
    triangle.angleB = [[AngleBTextFeild text] doubleValue];
    triangle.angleC = [[AngleCTextFeild text] doubleValue];
    [triangle solve];

    triDisplay.dataSource = self;
    [triDisplay setNeedsDisplay];
    [[self view] endEditing:YES];
    

    [self updateAll];
    [textVeiwSideA setEnabled:NO];
    [textVeiwSideB setEnabled:NO];
    [textVeiwSideC setEnabled:NO];
    [AngleATextFeild setEnabled:NO];
    [AngleBTextFeild setEnabled:NO];
    [AngleCTextFeild setEnabled:NO];
    
}


- (IBAction)clearPressed:(id)sender {
    
    textVeiwSideA.text = @"";
    textVeiwSideB.text = @"";
    textVeiwSideC.text = @"";
    AngleATextFeild.text = @"";
    AngleBTextFeild.text = @"";
    AngleCTextFeild.text = @"";
    triangle = nil; 
    triDisplay.dataSource = nil;
    [triDisplay setNeedsDisplay];
    [textVeiwSideA setEnabled:YES];
    [textVeiwSideB setEnabled:YES];
    [textVeiwSideC setEnabled:YES];
    [AngleATextFeild setEnabled:YES];
    [AngleBTextFeild setEnabled:YES];
    [AngleCTextFeild setEnabled:YES];
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

    [self setTextVeiwSideA:nil];
    [self setTextVeiwSideB:nil];
    [self setTextVeiwSideC:nil];
    [self setAngleATextFeild:nil];
    [self setAngleBTextFeild:nil];
    [self setAngleCTextFeild:nil];

    [self setTriDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    } else {
        return YES;
    }
     */
}

-(void) updateAll
{
    [AngleATextFeild setText: [NSString stringWithFormat:@"%.4f",triangle.angleA]];
    [AngleBTextFeild setText: [NSString stringWithFormat:@"%.4f",triangle.angleB]];
    [AngleCTextFeild setText: [NSString stringWithFormat:@"%.4f",triangle.angleC]];
    [textVeiwSideA setText:[NSString stringWithFormat:@"%.4f",triangle.sideA]];
    [textVeiwSideB setText:[NSString stringWithFormat:@"%.4f",triangle.sideB]];
    [textVeiwSideC setText:[NSString stringWithFormat:@"%.4f",triangle.sideC]];
    
}




@end
