//
//  CreateGroupViewController.h
//  Shoebox
//
//  Created by Stephen Derico on 6/3/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//
#import "SDDataManager.h"
#import "InviteViewController.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface NameGroupViewController : UITableViewController
@property (nonatomic, strong) NSArray *photos;
@end
