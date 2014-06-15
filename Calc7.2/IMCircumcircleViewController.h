//
//  IMCircumcircleViewController.h
//  Calc7.2
//
//  Created by iMill Industries on 3/22/14.
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

#import <UIKit/UIKit.h>
#import "IMTriangle.h"
#import "IMCircumcircleDrawView.h"


@interface IMCircumcircleViewController : UIViewController 

@property (strong, nonatomic) IMTriangle* triangle;

@property (weak, nonatomic) IBOutlet UITextField *pointOneXTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointTwoXTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointThreeXTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointOneYTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointTwoYTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointThreeYTextField;
@property (weak, nonatomic) IBOutlet UILabel *circumDiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerPointLabel;


@property (strong, nonatomic) IBOutlet IMCircumcircleDrawView *circumDrawView;


@end
