//
//  CalculatorBrain.m
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

#import "IMCalculatorBrain.h"

@interface CalculatorBrain()
@property(nonatomic, strong) NSMutableArray *operandStack;
@property(nonatomic, strong, readwrite) NSString *syntaxError;
@end

@implementation CalculatorBrain



@synthesize syntaxError     =_syntaxError;
@synthesize operandStack    =_operandStack;

-(NSMutableArray *) operandStack
{
    if (!_operandStack) _operandStack = [[NSMutableArray alloc]init];
    return _operandStack;

}

-(NSNumber *)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    //NSLog(@"popped operand %@",operandObject);
    if (operandObject) [self.operandStack removeLastObject];
    return operandObject;
    
}


-(NSString *) evaluateExpression:(NSString *)input
{

        
    
    //declare local variables. 
    NSString *inputChar;
    NSString *numberBuilder = [NSString stringWithFormat:@""];
    NSString *solution = @"not yet bob";
    NSMutableArray *inputStack =    [NSMutableArray arrayWithCapacity: [input length]];
    NSMutableArray *tokenized =     [NSMutableArray arrayWithCapacity:[input length]];
    NSMutableArray *outputQueue =   [NSMutableArray arrayWithCapacity:[input length]];
    NSMutableArray *stack =         [NSMutableArray arrayWithCapacity:[input length]];
    NSMutableArray *flippie =       [[NSMutableArray alloc]initWithCapacity:[input length]];
    NSString *iString;
    id token;   
    
    //wrap the input string into an array called inputStack
    for (int i = 0; i < [input length]; i++) 
    {
        iString = [NSString stringWithFormat: @"%C" , [input characterAtIndex: i]];
        [inputStack addObject: iString];
        
        
    }
    //NSLog(@"input %@",input);
    
    //wrap inputStack into an pretokenized Array. 
    while ([inputStack lastObject])
    {
        //NSLog(@"%@" ,numberBuilder);
        inputChar = [inputStack objectAtIndex:0];
        //if inputChar is an operator or function
        if ([inputChar isEqualToString:@"*"] || [inputChar isEqualToString:@"/"] || [inputChar isEqualToString:@"-"] || [inputChar isEqualToString:@"+"] || [inputChar isEqualToString:@"S"] || [inputChar isEqualToString:@"C"] || [inputChar isEqualToString:@"T"] || [inputChar isEqualToString:@"("] || [inputChar isEqualToString:@")"] || [inputChar isEqualToString:@"π"] || [inputChar isEqualToString:@"√"] || [inputChar isEqualToString:@"²"] || [inputChar isEqualToString:@"⁻"] )
        {
            
           // NSLog(@"operator or function in input");
            
            //if numberBuilder is not blank, add token wrapped number to tokenized array.
            if (![numberBuilder isEqualToString:@""]) {
                    [tokenized addObject: [NSNumber numberWithDouble:[numberBuilder doubleValue]]];
            }
            
            if ([inputChar isEqualToString: @"S"])
            {
                //SIN 
                if (  ([[inputStack objectAtIndex:1] isEqualToString:@"I"] && [[inputStack objectAtIndex:2] isEqualToString:@"N"]) || ([[inputStack objectAtIndex:1] isEqualToString:@"i"] && [[inputStack objectAtIndex:2] isEqualToString:@"n"]))
                {
                    [tokenized addObject:@"SIN"];
                    [inputStack removeObjectAtIndex:0];[inputStack removeObjectAtIndex:0];
                }
                else self.syntaxError = @"hello SIN error";
            }
            
            else if ([inputChar isEqualToString: @"T"])
            {
                //TAN
                if ( ([[inputStack objectAtIndex:1] isEqualToString:@"A"] && [[inputStack objectAtIndex:2] isEqualToString:@"N"]) || ([[inputStack objectAtIndex:1] isEqualToString:@"a"] && [[inputStack objectAtIndex:2] isEqualToString:@"n"]) )
                {
                    [tokenized addObject:@"TAN"];
                    [inputStack removeObjectAtIndex:0];[inputStack removeObjectAtIndex:0];
                }
                
                else self.syntaxError = @"hello TAN error";
            }
            
            else if ([inputChar isEqualToString: @"C"])
            {
                //COS 
                if ( ([[inputStack objectAtIndex:1] isEqualToString:@"O"] && [[inputStack objectAtIndex:2] isEqualToString:@"S"]) || ([[inputStack objectAtIndex:1] isEqualToString:@"o"] && [[inputStack objectAtIndex:2] isEqualToString:@"n"]) )
                {
                    [tokenized addObject:@"COS"];
                    [inputStack removeObjectAtIndex:0];
                    [inputStack removeObjectAtIndex:0];
                }
                else self.syntaxError = @"hello COS error";
            }
            
            //Pi and leftver tidbits
            else if ([inputChar isEqualToString:@"π"]) 
            {
                if ([[tokenized lastObject] doubleValue])
                {
                    //provides implecit multiplaction for pi and numbers and a number left of pi
                    //number to the right of pi needs added.
                    [tokenized addObject: @"*"];
                    
                }
                [tokenized addObject:[NSNumber numberWithDouble: M_PI]];
            }
            else if ([inputChar isEqualToString:@"("] && [[tokenized lastObject] doubleValue])
            {
                [tokenized addObject:@"*"];
                [tokenized addObject:@"("];

            }
            else if ([inputChar isEqualToString:@"²"]) 
            {
                [tokenized addObject: @"^"];
                [tokenized addObject:[NSNumber numberWithDouble:2.]];
            }
            else if ([inputChar isEqualToString:@"√"]) 
            {
                if ([[tokenized lastObject] doubleValue])
                {
                    [tokenized addObject: @"*"];
                }
                [tokenized addObject: @"sqrt"];
                //NSLog(@"squareRoot");
            }            
            else [tokenized addObject: inputChar];
            numberBuilder = @"";
        }       
        

        //if inputChar is an int, or could make a float.
        else if ([inputChar intValue] || [inputChar isEqualToString:@"."]||[inputChar isEqualToString:@"0"])
        {
            
            //if numberBuilder does not already contain a '.' or @"⁻"
            if ( [numberBuilder rangeOfString:@"."].location == NSNotFound ||  [numberBuilder rangeOfString:@"⁻"].location == NSNotFound)
            {
                //I can freely append the inputChar
                 numberBuilder = [numberBuilder stringByAppendingString:inputChar];
            }
            
            else if (![inputChar isEqualToString:@"."])
            {
                //if it does contain a "." make sure not to add it.
                numberBuilder = [numberBuilder stringByAppendingString:inputChar];
            }
           
            else if ([inputChar isEqualToString:@"."]){
                //and set the syntax error.
                numberBuilder = @"0";
                self.syntaxError = @"Invalid Decimal";
            }
 
            
        }
        
        else
        {
            //if inputChar is not an operator or function, nor could make a number
            //input is bad
            
            
            //***** Note, why Im not checking for @" " it should not cause error most of the time, and be removed when appropriate.
            //*** should this be done at the top or the bottom of the loop?
            
            self.syntaxError = @"sytaxError, Bad input";
            numberBuilder = @"0";//why am I setting numberBulder to @"0" rather than @""
            //NSLog(@"input char %@ numberbuilder %@",inputChar, numberBuilder);
        }
        [inputStack removeObjectAtIndex:0];
        
    }
    
    //if numberBuilder still has a value, (A number was last item in input) 
    //add it to stack. (it could be soution.)
    if (![numberBuilder isEqualToString:@""])
    {
    
        [tokenized addObject: [NSNumber numberWithDouble:[numberBuilder doubleValue]]];
    
    }
    

    // turn all tokens into token objects
    //NSLog(@"tokenized preFlip %@", tokenized);
    while ([tokenized lastObject])
    {
        
        [flippie addObject:[IMShuntingToken newTokenFromObject:[tokenized objectAtIndex:0]]];
        [tokenized removeObjectAtIndex:0];
    }
    [tokenized addObjectsFromArray:flippie];

    ////*** end of Tokenizing***

    
    
//***** tokenized should now be fixed, ONLY containg Token objects. ****//
        NSLog(@"tokenized going into the yard %@", tokenized);
    
// *** Shunting-yard ***
    
//  While there are tokens to be read:
    while ([tokenized lastObject]) 
    {   
        //NSLog(@"top of shunting while loop");
        //    Read a token.
        token = [tokenized objectAtIndex:0];
        
        //    If the token is a number, then add it to the output queue.
        if ([token numberValue]) 
        {
            [outputQueue addObject:token];
        }
        //    If the token is a function token, then push it onto the stack.
        else if ([token isFunction])
        {
            //NSLog(@"function in Yard");
            [stack addObject:token];
        }
        
        //If the token is a function argument separator (e.g., a comma):
        else if ([[token stringValue] isEqualToString:@","])
        {
            NSLog(@"how the hell did a comma get to the yard?");
            self.syntaxError = @"how did a comma get in the yard";
            
            // THIS PART OF THE YARD STILL NEEDS BUILT, BUT IT HAS NO USE AT THE MOMENT
            
            //Until the token at the top of the stack is a left parenthesis, pop operators off the stack onto the output queue. If no left parentheses are encountered, either the separator was misplaced or parentheses were mismatched.
        }
                
        
        //    If the token is an operator, o1, then:
        else if ([token precedence])
        {
            //NSLog(@"operators in the Yard");
   
            /*
             while there is an operator token, o2, at the top of the stack, and
             either o1 is left-associative and its precedence is less than or equal to that of o2,
             or o1 is right-associative and its precedence is less than that of o2,
             pop o2 off the stack, onto the output queue
             
             o1 is token
             o2 is last object 
             */
            
            while ([stack lastObject] &&
                   (( ![token isRightAssociative] && [token precedence] <= [[stack lastObject]precedence]) ||
                      ([token isRightAssociative] && [token precedence] <  [[stack lastObject]precedence]) ))
            {
                //pop o2 off the stack, onto the output queue
                [outputQueue addObject:[stack lastObject]];
                [stack removeLastObject];
            }
            //push o1 onto the stack
            [stack addObject:token];
        }
        
        //If the token is a left parenthesis, then push it onto the stack.
        else if ([[token stringValue] isEqualToString:@"("])[stack addObject: token];
            
        
        //If the token is a right parenthesis:
        else if ([[token stringValue] isEqualToString:@")"]) 
        {
            BOOL peek= NO;
            
            ///Until the token at the top of the stack is a left parenthesis, pop operators off the stack onto the output queue.

            while ([stack lastObject])
                
            {   
                if ([[[stack lastObject] stringValue] isEqualToString:@"("])
                {
                    peek = YES;
                    break;
                }
                
                else 
                {
                    [outputQueue addObject:[stack lastObject]];
                    [stack removeLastObject];                     
                }
            }
                
            //If the stack runs out without finding a left parenthesis, then there are mismatched parentheses
            if (!peek == YES)
            {
                //NSLog(@"parenthesis are are unmatch");
                self.syntaxError = @"mismatched parenthesis ()";
            }
            
            //Pop the left parenthesis from the stack, but not onto the output queue.
            [stack removeLastObject];
            
            //If the token at the top of the stack is a function token, pop it onto the output queue
            if ([stack lastObject])
            {
                if ([[stack lastObject] isFunction])
                {
                    [outputQueue addObject:[stack lastObject]];
                    [stack removeLastObject];
                    
                }
            }
        }
        
        
        
        else self.syntaxError = @"unknown token";
        
        //When there are no more tokens to read
        if ([tokenized count] == 1 )
        {
            //While there are still operator tokens in the stack:
            while ([stack lastObject])
            {
                //If the operator token on the top of the stack is a parenthesis, then there are mismatched parentheses
                if ([[[stack lastObject] stringValue] isEqualToString:@")"] || [[[stack lastObject]stringValue] isEqualToString:@"("])
                {
                    //NSLog(@"mismatch ()() at end of tokens");
                    self.syntaxError = [NSString stringWithFormat:@"extra '%@' " , [[stack lastObject] stringValue]];
                }
                //Pop the operator onto the output queue.
                [outputQueue addObject:[stack lastObject]];
                [stack removeLastObject];
            }
            
        }
        
        
        
        
        
        
        [tokenized removeObjectAtIndex:0];
    }
    


    //NSLog(@"shuntingYardOutPut %@",outputQueue);
    ///turn into number for display. 

    //while the ouputQueue has objects
    
    while ([outputQueue lastObject])
    {
        double result = 0; 
        //NSLog(@"preformOperations");
        token = [outputQueue objectAtIndex:0];
        if ([token numberValue])
        {
            [self.operandStack addObject:[token numberValue]];
        }
        else 

        
        if ([[token stringValue] isEqualToString: @"+"])
        {
            //NSLog(@"+");
            result = [[self popOperand]doubleValue] + [[self popOperand]doubleValue];
            [self.operandStack addObject:  [NSNumber numberWithDouble: result]];
            
        }
        
        else if ([[token stringValue] isEqualToString: @"*"])
        {
            //NSLog(@"*");
            result = [[self popOperand]doubleValue] * [[self popOperand]doubleValue];
            [self.operandStack addObject:  [NSNumber numberWithDouble: result]];

        }
        
        else if ([[token stringValue] isEqualToString: @"⁻"])
        {
            //NSLog(@"⁻");
            result = [[self popOperand]doubleValue] * -1.;
            [self.operandStack addObject:  [NSNumber numberWithDouble: result]];
            
        }
        
        else if ([[token stringValue] isEqualToString: @"-"])
        {
            //NSLog(@"-");
            double subtrahend = [[self popOperand] doubleValue];
            result = [[self popOperand]doubleValue] - subtrahend;
            [self.operandStack addObject:  [NSNumber numberWithDouble: result]];
            
        }
        
        else if ([[token stringValue] isEqualToString: @"/"])
        {
            //NSLog(@"/");
            double divisor = [[self popOperand]doubleValue];
            if (!divisor) self.syntaxError = @"You should not attempt to divide by zero";
            else result =  [[self popOperand]doubleValue] / divisor ;
            [self.operandStack addObject:  [NSNumber numberWithDouble: result]];
        }
        
        else if ([[token stringValue] isEqualToString: @"^"])
        {
            //NSLog(@"^");
            double exponent = [[self popOperand] doubleValue];
            double base = [[self popOperand] doubleValue];
            
            [self.operandStack addObject:[NSNumber numberWithDouble:pow(base, exponent)]];
            
        }
        else if ([[token stringValue] isEqualToString:@"SIN"])
        {
            result = sin([[self popOperand] doubleValue]* M_PI / 180);
            [self.operandStack addObject: [NSNumber numberWithDouble:result]];
        }
        else if ([[token stringValue] isEqualToString:@"TAN"])
        {
            result = tan([[self popOperand] doubleValue]* M_PI / 180);
            [self.operandStack addObject: [NSNumber numberWithDouble:result]];
        }
        else if ([[token stringValue] isEqualToString:@"COS"])
        {
            result = cos([[self popOperand] doubleValue]* M_PI / 180);
            [self.operandStack addObject: [NSNumber numberWithDouble:result]];
        }
        else if ([[token stringValue] isEqualToString: @"sqrt"])
        {
            //NSLog(@"sqrt");
            double base  = [[self popOperand] doubleValue];
            base = sqrt(base);
            [self.operandStack addObject:[NSNumber numberWithDouble:base]];
            
        }
        //NSLog(@"result %lf" ,result);
        
        
        [outputQueue removeObjectAtIndex:0];
        
        
    }
    
    //if the the operandStack contains more than one operand
    //something went wrong!! 
        
    if ([self.operandStack count] > 1 )
    {
        self.syntaxError = @"syntaxError";
    }
    
    // if there is a syntax error... 
    NSLog(@"outputQueue %@" , outputQueue);
    if (self.syntaxError)
    {
        //numberBuilder = @"";// Analize points outs out this value is never read, so I commented it out
        solution = self.syntaxError.description;
    }

    else if ([self.operandStack objectAtIndex:0])
    {
        solution =  [[[self.operandStack objectAtIndex:0]stringValue] stringByReplacingOccurrencesOfString:@"-" withString:@"⁻"];
        NSLog(@"operand stack exits with values %@",[self.operandStack description]);
    }
    if ([self.operandStack objectAtIndex:0]) [self.operandStack removeAllObjects];
    self.syntaxError = nil;
    return solution; 
    
}

@end

