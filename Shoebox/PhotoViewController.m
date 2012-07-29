//
//  PhotoViewController.m
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController
@synthesize imageView;
- (id)initWithImage:(UIImage*)image{
    self = [super init];
    
    if (self) {
 
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [scrollView setDelegate:self];
        [scrollView setContentSize:image.size];
        [scrollView setMinimumZoomScale:1.0];
        [scrollView setMaximumZoomScale:6.0];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [imageView setImage:image];
        
        [scrollView addSubview:imageView];
        [self.view addSubview:scrollView];
        
    }
    
    
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.navigationController.navigationBar setAlpha:0.0];
    [UIView commitAnimations];
 
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setWantsFullScreenLayout:YES];
    

 


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma UIScrollView

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
