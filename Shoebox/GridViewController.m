//
//  GridViewController.m
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
#import "GridViewController.h"

@interface GridViewController ()

@end

@implementation GridViewController
@synthesize photos = _photos;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        
    }
    return self;
}

- (id)initWithPhotos:(NSSet*)photos{

    self = [super init];
    if (self) {
        self.photos = photos;
        typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
        typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);
        
        // Custom initialization
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
     
        [scrollView setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:scrollView];
        CGRect __block rect = CGRectMake(5, 5, 100, 100);
        
        for (Photo *p in photos) {
            NSLog(@"Path %@",p.path);
         
            ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
            {
                ALAssetRepresentation *rep = [myasset defaultRepresentation];
                CGImageRef iref = [rep fullResolutionImage];
                if (iref) {

                    UIImage *image = [UIImage imageWithCGImage:iref];
                    UIImageView *iv = [[UIImageView alloc] initWithFrame:rect];
                    [iv setImage:image];
                    [iv setClipsToBounds:YES];
                    [iv setContentMode:UIViewContentModeScaleAspectFill];
                    NSLog(@"Added Rect %f,%f",rect.origin.x,rect.origin.y);
                    [scrollView addSubview:iv];
                    
                    
                    if (rect.origin.x +105 >= self.view.bounds.size.width) {
                         rect = CGRectMake(5, rect.origin.y + 105, rect.size.width, rect.size.height);
                     
                    }else{
                        rect = CGRectMake(rect.origin.x + 105, rect.origin.y, rect.size.width, rect.size.height);
                    
                    }
                      [scrollView setContentSize:CGSizeMake(rect.size.width, rect.size.height)];
                    
                }
            };
            
            
            
            //
            ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
            {
                NSLog(@"Can't get image - %@",[myerror localizedDescription]);
            };
            
            NSURL *asseturl = [NSURL URLWithString:p.path];
            ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
            [assetslibrary assetForURL:asseturl 
                           resultBlock:resultblock
                          failureBlock:failureblock];
            
        }
        
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

@end
