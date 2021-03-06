//
//  CalculatorBrain.m
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

//

#import "IMCalculatorBrain.h"

@interface IMCalculatorBrain()
@property(nonatomic, strong) NSMutableArray *operandStack;
@property(nonatomic, strong, readwrite) NSString *syntaxError;
@end

@implementation IMCalculatorBrain



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
    if (operandObject) [self.operandStack removeLastObject];
    return operandObject;
    
}


-(NSString *) evaluateExpression:(NSString *)input
{

    //declare local variables. 
    NSString *inputChar;
    NSString *numberBuilder = @"";
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
        if ([inputChar isEqualToString:@" "]) {
            [inputStack removeObjectAtIndex:0];
            inputChar = [inputStack objectAtIndex:0];
        }
        
        if ([inputChar isEqualToString:@"*"] || [inputChar isEqualToString:@"/"] || [inputChar isEqualToString:@"-"] || [inputChar isEqualToString:@"+"] || [inputChar isEqualToString:@"S"] || [inputChar isEqualToString:@"C"] || [inputChar isEqualToString:@"T"] || [inputChar isEqualToString:@"("] || [inputChar isEqualToString:@")"] || [inputChar isEqualToString:@"π"] || [inputChar isEqualToString:@"√"] || [inputChar isEqualToString:@"²"] || [inputChar isEqualToString:@"⁻"] )
        {
            
            //NSLog(@"operator or function in input");
            
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
                else self.syntaxError = @"SIN error";
            }
            
            else if ([inputChar isEqualToString: @"T"])
            {
                //TAN
                if ( ([[inputStack objectAtIndex:1] isEqualToString:@"A"] && [[inputStack objectAtIndex:2] isEqualToString:@"N"]) || ([[inputStack objectAtIndex:1] isEqualToString:@"a"] && [[inputStack objectAtIndex:2] isEqualToString:@"n"]) )
                {
                    [tokenized addObject:@"TAN"];
                    [inputStack removeObjectAtIndex:0];[inputStack removeObjectAtIndex:0];
                }
                
                else self.syntaxError = @"TAN error";
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
                else self.syntaxError = @"COS error";
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
            if ( [numberBuilder rangeOfString:@"."].location == NSNotFound || [numberBuilder rangeOfString:@"⁻"].location == NSNotFound)
            {
                //I can freely append the inputChar
                 numberBuilder = [numberBuilder stringByAppendingString:inputChar];
            }
           
            else if ([inputChar isEqualToString:@"."]){
                //and set the syntax error.
                numberBuilder = @"0";
                self.syntaxError = @"Bad Decimal";
            }
 
            
        }
        
        else
        {
            if (!self.syntaxError) self.syntaxError = @"syntaxError, Bad input";
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
    for (int i = 0; i < [tokenized count]; i++) {
        
        //if I have a a double to the right of an incoming π or ), I should add a * token
        if ([[[flippie lastObject] numberValue] doubleValue] == M_PI && [[tokenized objectAtIndex:i] doubleValue])
        {
            // losse the && above and peek at [tokenized atIndex: i];
            
           [flippie addObject:[IMShuntingToken newTokenFromObject:@"*"]];
        }
        
        else if ([[[flippie lastObject] stringValue] isEqualToString: @")"])
        {
            if ([[tokenized objectAtIndex:i] doubleValue])
            {
                [flippie addObject:[IMShuntingToken newTokenFromObject:@"*"]];
            }
            else if ([[tokenized objectAtIndex: i] isEqualToString:@"("])
            {
                [flippie addObject:[IMShuntingToken newTokenFromObject:@"*"]];
            }
        }
        
        
        [flippie addObject:[IMShuntingToken newTokenFromObject:[tokenized objectAtIndex:i]]];
    }
    
    [tokenized removeAllObjects];
    [tokenized addObjectsFromArray:flippie];

    
    
//***** tokenized should now be fixed, ONLY containg Token objects. ****//
        //NSLog(@"tokenized going into the yard %@", tokenized);
    
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
                self.syntaxError = @"extra '('";
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
        if (!self.syntaxError)
        {
            //NSLog(@"OutputStack: %@", self.operandStack);
            self.syntaxError = @"syntaxError";
        }
    }
    
    // if there is a syntax error... 

    if (self.syntaxError)
    {
        solution = self.syntaxError.description;
        //NSLog(@"outputQueue %@" , outputQueue);
    }

    else if ([self.operandStack objectAtIndex:0])
    {
        solution =  [[[self.operandStack objectAtIndex:0]stringValue] stringByReplacingOccurrencesOfString:@"-" withString:@"⁻"];
        //NSLog(@"operand stack exits with values %@",[self.operandStack description]);
    }
    if ([self.operandStack objectAtIndex:0]) [self.operandStack removeAllObjects];
    self.syntaxError = nil;
    return solution; 
    
}

@end

