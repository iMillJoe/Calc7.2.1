//
//  IMCalculatorViewController.m
//
//  Created by iMill Industries on 3/2/12.
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


/*
 To do list
 spell check everything, I am a bad speller.
 
 
 */

#import "IMCalculatorViewController.h"
#import "IMCalculatorBrain.h"


//private API declarations.
@interface IMCalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringAnExpression;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSString *numberString;
@property (nonatomic, strong) NSString *lastAnswer;
@end


@implementation IMCalculatorViewController
@synthesize brain = _brain;
@synthesize currentExpression = _currentExpression;
@synthesize numberString = _numberString;
@synthesize answerView = _answerView;
@synthesize lastAnswer = _lastAnswer;
@synthesize userIsInTheMiddleOfEnteringAnExpression =_userIsInTheMiddleOfEnteringAnExpression;

-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc]init];
    return _brain;
}


- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
  
    if (self.userIsInTheMiddleOfEnteringAnExpression)
    {
        self.currentExpression.text = [self.currentExpression.text stringByAppendingString:digit];
    }
    else if (![digit isEqualToString: @"0"])
    {
        self.currentExpression.text   = digit;
        self.userIsInTheMiddleOfEnteringAnExpression = YES;
    }
    [[UIDevice currentDevice] playInputClick]; /// WHY DOESN"T IT CLICK????? WHY WHY WHY.
    //NSLog(@"%@ pressed, ",digit);
    
}

- (IBAction)OperatorPressed:(UIButton *)sender 
{
    if (self.answerView.text && !self.userIsInTheMiddleOfEnteringAnExpression )
        {
            if ([self.lastAnswer doubleValue])
            {
                
                self.currentExpression.text = self.lastAnswer;
                self.userIsInTheMiddleOfEnteringAnExpression = YES;
        
            }
        }
    if (!([self.currentExpression.text hasSuffix:@"-"] || [self.currentExpression.text hasSuffix:@"+"] ||
             [self.currentExpression.text hasSuffix:@"*"] || [self.currentExpression.text hasSuffix:@"/"]) )
    {
        self.currentExpression.text = [self.currentExpression.text stringByAppendingString: sender.currentTitle];
    } 
    [[UIDevice currentDevice] playInputClick];
}

- (IBAction)squarePressed
{
    if (self.userIsInTheMiddleOfEnteringAnExpression == NO && [self.currentExpression.text isEqualToString:@"0"] ) 
    {
        self.currentExpression.text = self.lastAnswer;
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
    NSString* ans = [self.brain evaluateExpression:self.currentExpression.text];
    self.lastAnswer = ans;
    self.answerView.text = [self.answerView.text stringByAppendingFormat:@"\r%@ = %@" , self.currentExpression.text , ans ];
    [self.answerView scrollRangeToVisible:NSMakeRange([self.answerView.text length], 0)];
    
    self.currentExpression.text=@"0";//**** !! OR blinking curser !!

    //self.brain.syntaxError =  nil;
}


- (IBAction)backSpacePressed 
{
    if ([self.currentExpression.text length] > 0)
    {
        if (![self.currentExpression.text isEqualToString:@"0"]) {
            self.currentExpression.text = [self.currentExpression.text substringToIndex: [self.currentExpression.text length] -1];
        }
        
    }
    if ([self.currentExpression.text isEqualToString:@""]) {
        self.currentExpression.text = @"0";
        self.userIsInTheMiddleOfEnteringAnExpression = NO;
    }
}

- (IBAction)clearPressed 
{
    if ([self.currentExpression.text isEqualToString:@"0"])
    {
        self.answerView.text = @"";
        self.lastAnswer=@"";
    }
    self.currentExpression.text = @"0";
    self.userIsInTheMiddleOfEnteringAnExpression=NO;
}

- (IBAction)negitivePressed {
    
    
    if ([self.currentExpression.text hasSuffix:@"-"] || [self.currentExpression.text hasSuffix:@"+"] ||
        [self.currentExpression.text hasSuffix:@"*"] || [self.currentExpression.text hasSuffix:@"/"] ||
        [self.currentExpression.text hasSuffix:@"("] || [self.currentExpression.text hasSuffix:@"√"] ||
        [self.currentExpression.text hasSuffix:@"N"] || [self.currentExpression.text hasSuffix:@"S"])
    {
        self.currentExpression.text = [self.currentExpression.text stringByAppendingString:@"⁻"];
    }
    
    else if ([self.currentExpression.text isEqualToString:@"0"])
    {
        self.currentExpression.text = @"⁻";
        self.userIsInTheMiddleOfEnteringAnExpression = YES;
    }
}

- (IBAction)ansPresed
{
    if (self.lastAnswer) {
        if ([self.currentExpression.text isEqualToString:@"0"]) {
            self.currentExpression.text = self.lastAnswer;
        }
        else self.currentExpression.text = [self.currentExpression.text stringByAppendingString:self.lastAnswer];
        
    }

}


-(BOOL)enableInputClicksWhenVisible
{
    return YES;
}


/*
-(void)viewDidLoad
{

}
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end
