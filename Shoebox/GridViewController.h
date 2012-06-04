//
//  GridViewController.h
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//
#import "InviteViewController.h"
#import "PhotoViewController.h"
#import "Group.h"
#import "Photo.h"
#import <UIKit/UIKit.h>

@interface GridViewController : UIViewController
@property (nonatomic, strong) NSSet  *photos;
@property (nonatomic, strong) Group *group;
- (id)initWithGroup:(Group*)group;

@end
