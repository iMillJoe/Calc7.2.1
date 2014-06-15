//
//  IMTriangleDrawVeiw.h
//  Triangle Calculator
//
//  Created by iMill Industries on 5/12/12.
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

@protocol IMTriangleDrawViewDataSource
-(IMTriangle *) triangle;
@end

@interface IMTriangleDrawVeiw : UIView
@property (nonatomic , weak) id <IMTriangleDrawViewDataSource> dataSource;

@end
