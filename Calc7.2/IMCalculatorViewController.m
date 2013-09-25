//
//  IMCalculatorViewController.m
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


/*
 To do list
 
 
 get better, and customized backdrop
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
    if (self.answerView.text && !self.userIsInTheMiddleOfEnteringAnExpression)
        {   
            self.currentExpression.text = [self.lastAnswer stringByAppendingString:sender.currentTitle];
            
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
    self.lastAnswer = [self.brain evaluateExpression:self.currentExpression.text];
    self.answerView.text = [self.answerView.text stringByAppendingFormat:@"\r%@ = %@" , self.currentExpression.text , [self.brain evaluateExpression: self.currentExpression.text]];
    [self.answerView scrollRangeToVisible:NSMakeRange([self.answerView.text length], 0)];
    
    self.currentExpression.text=@"0";//**** !! OR blinking curser !!

    self.brain.syntaxError =  nil;
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
    
    
    if ([self.currentExpression.text hasSuffix:@"-"] || [self.currentExpression.text hasSuffix:@"+"] || [self.currentExpression.text hasSuffix:@"*"] || [self.currentExpression.text hasSuffix:@"/"] ) {
        self.currentExpression.text = [self.currentExpression.text stringByAppendingString:@"⁻"]
        ;
    } else if ([self.currentExpression.text isEqualToString:@"0"]){
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



-(void)viewDidLoad
{

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end
