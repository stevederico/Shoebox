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

@implementation GridViewController{
    SDFooterButtonView *footer;
}
@synthesize photos = _photos;
@synthesize group = _group;
@synthesize scrollView = _scrollView;

- (id)initWithGroup:(PFObject*)group{

    self = [super init];
    if (self) {
        self.group = group;
        self.title = [group objectForKey:@"Name"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,  self.view.bounds.size.height)];
          [self.scrollView setContentOffset:CGPointMake(0.0f, self.scrollView.contentSize.height) animated:NO];
        [self.scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 175.0f, 0.0f)];
        [self.view addSubview:self.scrollView];

        footer = [[SDFooterButtonView alloc] initWithStyle:SDFooterButtonStyleGreen];
        [footer setFrame:CGRectZero];
        [footer.button setTitle:@"Add Photos" forState:UIControlStateNormal];
        [footer.button addTarget:self action:@selector(showUpload) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:footer];
        

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(viewDidAppear:) 
                                                     name:@"PhotoDone"
                                                   object:nil];
               
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarStyle: UIBarStyleBlackTranslucent];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.wantsFullScreenLayout = YES;
      [self.scrollView setContentOffset:CGPointMake(0.0f, self.scrollView.contentSize.height) animated:NO];
    
	// Do any additional setup after loading the view.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIBarButtonItem *inviteButton = [[UIBarButtonItem alloc] initWithTitle:@"Invite" style:UIBarButtonItemStyleBordered target:self  action:@selector(showInvite)];
    self.navigationItem.rightBarButtonItem = inviteButton;

    [self.scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 175.0f, 0.0f)];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self.scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 175.0f, 0.0f)];
    [self.scrollView setContentOffset:CGPointMake(0.0f, self.scrollView.contentSize.height-275.0f) animated:NO];
  
    
    NSLog(@"Height %f", self.view.bounds.size.height);
    NSLog(@"Place %f", self.view.bounds.size.height -65);
    [footer setFrame:CGRectMake(0, self.view.bounds.size.height - 65.0f,  self.view.bounds.size.width, 50.0f)];

    PFRelation *relation = [self.group relationforKey:@"Photos"];
    PFQuery *q = [relation query];
    [q setCachePolicy:kPFCachePolicyNetworkElseCache ];
    [q orderByAscending:@"updatedAt"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *result, NSError *error) {
        if (error) {
            // There was an error
        } else {
            // results have all the Posts the current user liked.
            if ([result count]>self.photos.count) {
                self.photos = result;
                [self setupThumbs];
            }
          
        }
        
    }];

}

- (void)setupThumbs{
    
    CGRect __block rect = CGRectMake(5, 70, 100, 100);
    int i = 1;
    for (PFObject *p in self.photos) {
        
        NSData *data = [[p objectForKey:@"file"] getData];
        UIImage *image = [UIImage imageWithData:data];
        UIButton *b = [[UIButton alloc] initWithFrame:rect];
        [b setImage:image forState:UIControlStateNormal];
        [b setClipsToBounds:YES];
        [b setTag:i];
        i++;
        [b.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [b setAdjustsImageWhenHighlighted:NO];
        [b addTarget:self action:@selector(showPhoto:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"Added Rect %f,%f",rect.origin.x,rect.origin.y);
        [self.scrollView addSubview:b];
        
        if (rect.origin.x +105 >= self.view.bounds.size.width) {
            rect = CGRectMake(5, rect.origin.y + 105, rect.size.width, rect.size.height);
            
        }else{
            rect = CGRectMake(rect.origin.x + 105, rect.origin.y, rect.size.width, rect.size.height);
            
        }
        
        NSLog(@"ContentSize: %f %f",rect.origin.x,rect.origin.y);

        [self.scrollView setContentSize:CGSizeMake(rect.origin.x,rect.origin.y)];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, rect.origin.y + 110, self.view.bounds.size.width, 25.0f)];
    [label setText:[NSString stringWithFormat:@"%d Photos, Last Updated %@",self.photos.count,self.title]];
    [label setTextColor:[UIColor lightGrayColor]];
    [label setTextAlignment:UITextAlignmentCenter];
    [self.scrollView addSubview:label];
    [self.scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 175.0f, 0.0f)];
    [self.scrollView setContentOffset:CGPointMake(0.0f, self.scrollView.contentSize.height-275.0f) animated:NO];

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



#pragma GridViewController


-(void)showPhoto:(id)sender{
    
    UIButton *b = (UIButton*)sender;
    UIImage *image = b.imageView.image;
    
    PhotoViewController *pvc = [[PhotoViewController alloc] initWithImage:image];
    [pvc setTitle:[NSString stringWithFormat:@"%d of %d",[sender tag],self.photos.count]];
    
    [self.navigationController pushViewController:pvc animated:YES];

}

- (void)showInvite{

    InviteViewController *ivc = [[InviteViewController alloc] initWithGroup:self.group];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ivc];
    [self.navigationController presentModalViewController:nav animated:YES];

}

#pragma ELCImagePickerControllerDelegate

- (void)showUpload{
    
    ELCAlbumPickerController *avc = [[ELCAlbumPickerController alloc] initWithStyle:UITableViewStyleGrouped];
    ELCImagePickerController *controller  = [[ELCImagePickerController alloc] initWithRootViewController:avc];
    [avc setParent:controller];  
    [controller setDelegate:self];
    [self presentModalViewController:controller animated:YES];
    
    
}


- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    

    NSArray *photos = info;
    //add photos to group
    
    SDDataManager *dm = [[SDDataManager alloc] init];
    [dm addPhotos:photos ToGroup:self.group];
    
    [self dismissModalViewControllerAnimated:YES];
    
    
    
    
}
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
    
    [self dismissModalViewControllerAnimated:YES];
    
}







- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
