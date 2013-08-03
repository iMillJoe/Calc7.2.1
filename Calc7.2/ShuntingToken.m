//
//  ShuntingToken.m
//
//  Created by Joseph Million on 3/8/12.
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

#import "ShuntingToken.h"

@implementation ShuntingToken


@synthesize isRightAssociative = _isRightAssociative;
@synthesize isFunction = _isFunction;
@synthesize precedence  = _precedence;
@synthesize numberValue = _numberValue;
@synthesize stringValue = _stringValue;
@synthesize description = _description;



+(ShuntingToken *) newTokenFromObject: (id) input;
{
    ShuntingToken *newToken = [[ShuntingToken alloc]init];
    
    if ([input isKindOfClass:[NSNumber class]])
    {
        newToken.numberValue = input;
        newToken.description = [newToken.numberValue stringValue];
    }
    
    else if ([input isKindOfClass:[NSString class]])
    {
        
        newToken.stringValue = input;
        newToken.description = input;
        if ([input isEqualToString:@"^"])
        {
            newToken.isRightAssociative = YES;
            newToken.precedence= 4;
        }
        else if ([input isEqualToString:@"sqrt"])
        {
            newToken.isRightAssociative = NO;
            newToken.precedence= 4;
        }
        else if ([input isEqualToString:@"*"] || [input isEqualToString:@"/"])
        {

            newToken.precedence = 3;
            newToken.isRightAssociative = NO;
        }
        else if ([input isEqualToString:@"+"] || [input isEqualToString:@"-"])
        {

            newToken.precedence = 2;
            newToken.isRightAssociative = NO;
        }
        else if ([input isEqualToString:@"SIN"]||[input isEqualToString:@"TAN"]||[input isEqualToString:@"COS"])
        {
            newToken.precedence = 3;
            newToken.isRightAssociative = YES;
        }
        else 
        {
            //redundant
            newToken.description = input;
        }
        
    }
    else newToken.description = @"token did not generate"; 

    
    if (newToken.precedence) newToken.description = [newToken.description stringByAppendingFormat:@" precidence = %i rightAssociative= %i", newToken.precedence , newToken.isRightAssociative];
    return newToken;
}
@end
