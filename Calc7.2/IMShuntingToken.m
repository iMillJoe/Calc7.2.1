//
//  IMShuntingToken.m
//
//  Created by iMill Industries on 8/2/13.
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

#import "IMShuntingToken.h"

@implementation IMShuntingToken


@synthesize isRightAssociative = _isRightAssociative;
@synthesize isFunction = _isFunction;
@synthesize precedence  = _precedence;
@synthesize numberValue = _numberValue;
@synthesize stringValue = _stringValue;
@synthesize description = _description;



+(IMShuntingToken *) newTokenFromObject: (id) input;
{
    IMShuntingToken *newToken = [[IMShuntingToken alloc]init];
    
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
        
        else if ([input isEqualToString:@"⁻"])
        {
            newToken.precedence = 3;
            newToken.isRightAssociative = YES;
            
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
            //redundant, perhaps an errror?
            newToken.description = input;
        }
        
    }
    else newToken.description = @"token did not generate"; 

    
    if (newToken.precedence) newToken.description = [newToken.description stringByAppendingFormat:@" precidence = %i rightAssociative= %i", newToken.precedence , newToken.isRightAssociative];
    
    return newToken;
}
@end
