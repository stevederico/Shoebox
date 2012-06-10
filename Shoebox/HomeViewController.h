//
//  HomeViewController.h
//  Shoebox
//
//  Created by Stephen Derico on 6/3/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import "GridViewController.h"
#import "NameGroupViewController.h"
#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"
#import <UIKit/UIKit.h>

@interface HomeViewController : UITableViewController <ELCImagePickerControllerDelegate>{
    ELCImagePickerController *controller ;
}
@property (nonatomic, strong) NSArray *groups;

@end
