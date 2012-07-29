//
//  GridViewController.h
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//
#import "SDDataManager.h"
#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"
#import "InviteViewController.h"
#import "PhotoViewController.h"
#import <UIKit/UIKit.h>
#import "EGOPhotoViewController.h"
#import "EGOPhotoSource.h"


@interface GridViewController : SSCollectionViewController
@property (nonatomic, strong) NSArray  *photos;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) PFObject *group;

- (id)initWithGroup:(PFObject*)group;

@end
