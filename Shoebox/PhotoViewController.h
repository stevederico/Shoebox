//
//  PhotoViewController.h
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
- (id)initWithImage:(UIImage*)image;

@end
