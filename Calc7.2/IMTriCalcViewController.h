//
//  IMTriCalcViewController.h
//  Triangle Calculator
//
//  Created by Joseph Million on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMTriangleDrawVeiw.h"
#import "IMTriangle.h"


@interface IMTriCalcViewController : UIViewController <UITextFieldDelegate>


@property (strong, nonatomic) IMTriangle *triangle;

@property (weak, nonatomic) IBOutlet UITextField *textVeiwSideA;
@property (weak, nonatomic) IBOutlet UITextField *textVeiwSideB;
@property (weak, nonatomic) IBOutlet UITextField *textVeiwSideC;
@property (weak, nonatomic) IBOutlet UITextField *AngleATextFeild;
@property (weak, nonatomic) IBOutlet UITextField *AngleBTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *AngleCTextFeild;

@property (weak, nonatomic) IBOutlet IMTriangleDrawVeiw *triDisplay;


-(void) updateAll;


@end
