//
//  IMCircumcircleViewController.m
//  Calc7.2
//
//  Created by Joe Million on 3/22/14.
//  Copyright (c) 2014 iMillIndustries. All rights reserved.
//

#import "IMCircumcircleViewController.h"

@interface IMCircumcircleViewController ()

@end

@implementation IMCircumcircleViewController
@synthesize triangle = triangle;




- (IBAction)clearButtonPressed:(id)sender {
}



- (IBAction)solveButtonPressed:(id)sender {
    
    
    
    CGPoint pointA = CGPointMake([[self.pointOneXTextField text] doubleValue], [[self.pointOneYTextField text] doubleValue]);
    CGPoint pointB = CGPointMake([[self.pointTwoXTextField text] doubleValue], [[self.pointTwoYTextField text] doubleValue]);
    CGPoint pointC = CGPointMake([[self.pointThreeXTextField text] doubleValue], [[self.pointThreeYTextField text] doubleValue]);
    
    if (!triangle)
    {
        triangle = [[IMTriangle alloc] initFromThreePointsWithPointA:pointA pointB:pointB andPointC:pointC usingDegrees:YES];
    }
    
    
    
    [[self view] endEditing:YES];
    
    /*
    triDisplay.dataSource = self;
    [triDisplay setNeedsDisplay];
    
    
    
    [self updateAll];
    [textVeiwSideA setEnabled:NO];
    [textVeiwSideB setEnabled:NO];
    [textVeiwSideC setEnabled:NO];
    [AngleATextFeild setEnabled:NO];
    [AngleBTextFeild setEnabled:NO];
    [AngleCTextFeild setEnabled:NO];
     */
}









- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
