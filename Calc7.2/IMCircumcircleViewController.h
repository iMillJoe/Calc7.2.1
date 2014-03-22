//
//  IMCircumcircleViewController.h
//  Calc7.2
//
//  Created by Joe Million on 3/22/14.
//  Copyright (c) 2014 iMillIndustries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMTriangle.h"

@interface IMCircumcircleViewController : UIViewController

@property (strong, nonatomic) IMTriangle* triangle;

@property (weak, nonatomic) IBOutlet UITextField *pointOneXTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointTwoXTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointThreeXTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointOneYTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointTwoYTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointThreeYTextField;


@end
