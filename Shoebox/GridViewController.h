//
//  GridViewController.h
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//
#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"
#import "InviteViewController.h"
#import "PhotoViewController.h"
#import "Group.h"
#import "Photo.h"
#import <UIKit/UIKit.h>

@interface GridViewController : UIViewController
@property (nonatomic, strong) NSSet  *photos;
@property (nonatomic, strong) PFObject *group;
- (id)initWithGroup:(PFObject*)group;

@end
