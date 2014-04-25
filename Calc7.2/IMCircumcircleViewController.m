//
//  IMCircumcircleViewController.m
//  Calc7.2
//
//  Created by Joe Million on 3/22/14.
//  Copyright (c) 2014 iMillIndustries. All rights reserved.
//

#import "IMCircumcircleViewController.h"
#import "IMCircumcircleDrawView.h"

@interface IMCircumcircleViewController () <IMTriangleCircumcircleDrawViewDataSource>

@end

@implementation IMCircumcircleViewController
@synthesize triangle = _triangle;
@synthesize circumDrawView = _circumDrawView;




- (IBAction)clearButtonPressed:(id)sender {
    self.pointOneXTextField.text = nil;
    self.pointOneYTextField.text = nil;
    self.pointTwoXTextField.text = nil;
    self.pointTwoYTextField.text = nil;
    self.pointThreeXTextField.text = nil;
    self.pointThreeYTextField.text = nil;
    
    
    self.triangle = nil;
    self.circumDrawView.dataSource = nil;
    [self.circumDrawView setNeedsDisplay];
    
    
    
    
}




- (IBAction)solveButtonPressed:(id)sender {
    
    
    
    CGPoint pointA = CGPointMake([[self.pointOneXTextField text] doubleValue], [[self.pointOneYTextField text] doubleValue]);
    CGPoint pointB = CGPointMake([[self.pointTwoXTextField text] doubleValue], [[self.pointTwoYTextField text] doubleValue]);
    CGPoint pointC = CGPointMake([[self.pointThreeXTextField text] doubleValue], [[self.pointThreeYTextField text] doubleValue]);
    
    if (!self.triangle)
    {
        self.triangle = [[IMTriangle alloc] initFromThreePointsWithPointA:pointA pointB:pointB andPointC:pointC usingDegrees:YES];
    }
    
    [[self view] endEditing:YES];
    [self.circumDrawView setNeedsDisplay];
    self.circumDrawView.dataSource = self;
    NSLog(@"End of solveButtonPressed for tri: %@", self.triangle);
    
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
    self.circumDrawView.dataSource = self;
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
