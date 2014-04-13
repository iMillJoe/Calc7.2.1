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
    
    self.triangle.SideA  = [[self.textVeiwSideA text] doubleValue];
    self.triangle.SideB  = [[self.textVeiwSideB text] doubleValue];
    self.triangle.SideC  = [[self.textVeiwSideC text] doubleValue];
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

    self.TextVeiwSideA = nil;
    self.TextVeiwSideB = nil;
    self.TextVeiwSideC = nil;
    self.angleATextFeild = nil;
    self.angleBTextFeild = nil;
    self.angleCTextFeild = nil;

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
    [self.AngleATextFeild setText: [NSString stringWithFormat:@"%.4f", self.triangle.angleA]];
    [self.AngleBTextFeild setText: [NSString stringWithFormat:@"%.4f", self.triangle.angleB]];
    [self.AngleCTextFeild setText: [NSString stringWithFormat:@"%.4f", self.triangle.angleC]];
    [self.textVeiwSideA setText:[NSString stringWithFormat:@"%.4f", self.triangle.sideA]];
    [self.textVeiwSideB setText:[NSString stringWithFormat:@"%.4f", self.triangle.sideB]];
    [self.textVeiwSideC setText:[NSString stringWithFormat:@"%.4f", self.triangle.sideC]];
    
}




@end
