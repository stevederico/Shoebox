//
//  GridViewController.h
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//
#import "Photo.h"
#import <UIKit/UIKit.h>

@interface GridViewController : UIViewController
@property (nonatomic, strong) NSSet  *photos;

- (id)initWithPhotos:(NSSet*)photos;

@end
