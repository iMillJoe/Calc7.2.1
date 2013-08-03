//
//  CalculatorViewController.m
//
//  Created by Joseph Million on 3/2/12.
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

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"






/*
To do list
 
 
 get better, and customized backdrop
 
 
 Build an array/store that is the expression and it's answer into that app,
 create a method that prints from this
 
 spell check everything, I am a bad speller.
 

*/

//private API declarations.
@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringAnExpression;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSString *numberString;
@property (nonatomic, strong) NSArray *expressionHistory;
@end


@implementation CalculatorViewController 
@synthesize brain = _brain;
@synthesize currentExpression = _currentExpression;
@synthesize numberString = _numberString;
@synthesize answerView = _answerView;

@synthesize userIsInTheMiddleOfEnteringAnExpression =_userIsInTheMiddleOfEnteringAnExpression;


-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc]init];
    return _brain;
}



///seperate digets pressed from operaters pressed... ie, if a number exists in the past display, and I hit  + - * or / i should the last display appended with *.... 
- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
  
    if (self.userIsInTheMiddleOfEnteringAnExpression)
    {
        self.currentExpression.text   = [self.currentExpression.text stringByAppendingString:digit];
    }
    else if (![[sender currentTitle] isEqualToString: @"0"])
    {
        self.currentExpression.text   = digit;
        self.userIsInTheMiddleOfEnteringAnExpression = YES;
    }
    [[UIDevice currentDevice] playInputClick];
    //NSLog(@"%@ pressed, ",digit);
    
}

- (IBAction)OperatorPressed:(UIButton *)sender 
{
    if (self.answerView.text && !self.userIsInTheMiddleOfEnteringAnExpression)
        {   
            self.currentExpression.text = @"result of last expression appended with operator touched";
            
            self.userIsInTheMiddleOfEnteringAnExpression = YES;
        }
    else 
    {
        self.currentExpression.text = [self.currentExpression.text stringByAppendingString:sender.currentTitle];
    } 
    [[UIDevice currentDevice] playInputClick];
}






- (IBAction)squarePressed
{
    if (self.userIsInTheMiddleOfEnteringAnExpression == NO && [self.currentExpression.text isEqualToString:@"0"] ) 
    {
        self.currentExpression.text = @"It is needed that put the Ans from last expession hear, appended by a square symbol";
        self.userIsInTheMiddleOfEnteringAnExpression = YES;
    }
    self.currentExpression.text = [self.currentExpression.text stringByAppendingString:@"²"];
}

- (IBAction)squareRootPressed 
{
    if (self.userIsInTheMiddleOfEnteringAnExpression == NO)
    { 
        self.currentExpression.text = @"√";
        self.userIsInTheMiddleOfEnteringAnExpression = YES;
    }
    else self.currentExpression.text=[self.currentExpression.text stringByAppendingString:@"√"];
}

- (IBAction)enterPressed 
{

    self.userIsInTheMiddleOfEnteringAnExpression = NO;

    self.answerView.text = [self.answerView.text stringByAppendingFormat:@"\r%@ = %@" , self.currentExpression.text , [self.brain evaluateExpression: self.currentExpression.text]];
    [self.answerView scrollRangeToVisible:NSMakeRange([self.answerView.text length], 0)];
    
    self.currentExpression.text=@"0";//**** !! OR blinking curser !!

    self.brain.syntaxError =  nil;
}


- (IBAction)backSpacePressed 
{
    if ([self.currentExpression.text length] > 0)
    {
        self.currentExpression.text = [self.currentExpression.text substringToIndex: [self.currentExpression.text length] -1];
    }
}

- (IBAction)clearPressed 
{
    if ([self.currentExpression.text isEqualToString:@"0"])
    {
        self.answerView.text = @"";
    }
    self.currentExpression.text = @"0";
    self.userIsInTheMiddleOfEnteringAnExpression=NO;
}


- (IBAction)ansPresed
{
    if (![self.answerView.text isEqualToString:@""])
    {
        if ([self.answerView.text isEqualToString:@"0"] && self.answerView.text)
        {
            self.currentExpression.text = @"the Ans from the last Operaton";
            self.userIsInTheMiddleOfEnteringAnExpression = YES;
        }

        else if (self.answerView.text)
        {
            
            /// I CLEARLY need to do something hear
            
             if ([[self.currentExpression.text substringFromIndex:[self.currentExpression.text length]-1] isEqualToString:@"*"] || [[self.currentExpression.text substringFromIndex:[self.currentExpression.text length]-1] isEqualToString:@"+"] || [[self.currentExpression.text substringFromIndex:[self.currentExpression.text length]-1] isEqualToString:@"/"] || [[self.currentExpression.text substringFromIndex:[self.currentExpression.text length]-1] isEqualToString:@"-"] ||[[self.currentExpression.text substringFromIndex:[self.currentExpression.text length]-1] isEqualToString:@"√"])
            {
                self.currentExpression.text = [self.currentExpression.text stringByAppendingString:@"result of last exxpretion"];
                
            }
        }
        else 
        {
            self.currentExpression.text = @"0";
        }       
        
    }           

}


-(BOOL)enableInputClicksWhenVisible
{
    return YES;
}



-(void)viewDidLoad
{

}








- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}




/*- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setCurrentExpression:nil];
    [self setResultOfLastExpression:nil];
    [self setLastExpression:nil];
    [self setResultOfSecondFromLastExpression:nil];
    [self setSecondFromLastExpression:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

 */



@end
