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
@synthesize group = _group;

- (id)initWithGroup:(PFObject*)group{

    self = [super init];
    if (self) {
        
        self.title = [group objectForKey:@"Name"];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,  self.view.bounds.size.height - 50)];
        [self.view addSubview:scrollView];
        
        SDFooterButtonView *footer = [[SDFooterButtonView alloc] initWithStyle:SDFooterButtonStyleGreen];
        [footer setFrame:CGRectMake(0, 350,  self.view.bounds.size.width, 50.0f)];
        [footer.button setTitle:@"Add Photos" forState:UIControlStateNormal];
        [footer.button addTarget:self action:@selector(showUpload) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:footer];
        
        
        PFRelation *relation = [group relationforKey:@"Photos"];
        
        [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *result, NSError *error) {
            if (error) {
                // There was an error
            } else {
                // results have all the Posts the current user liked.
                CGRect __block rect = CGRectMake(5, 5, 100, 100);
                
                for (PFObject *p in result) {

                    NSData *data = [[p objectForKey:@"file"] getData];
                    UIImage *image = [UIImage imageWithData:data];
                    UIButton *b = [[UIButton alloc] initWithFrame:rect];
                    [b setImage:image forState:UIControlStateNormal];
                    [b setClipsToBounds:YES];
                    [b.imageView setContentMode:UIViewContentModeScaleAspectFill];
                    [b addTarget:self action:@selector(showPhoto:) forControlEvents:UIControlEventTouchUpInside];
                    NSLog(@"Added Rect %f,%f",rect.origin.x,rect.origin.y);
                    [scrollView addSubview:b];
                    
                    
                    if (rect.origin.x +105 >= self.view.bounds.size.width) {
                        rect = CGRectMake(5, rect.origin.y + 105, rect.size.width, rect.size.height);
                        
                    }else{
                        rect = CGRectMake(rect.origin.x + 105, rect.origin.y, rect.size.width, rect.size.height);
                        
                    }
                    [scrollView setContentSize:CGSizeMake(rect.size.width, rect.size.height)];
                    
                    
                    
                    
                }
            }
        }];
        
        
        // Custom initialization
    
  
        
       
        
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *inviteButton = [[UIBarButtonItem alloc] initWithTitle:@"Invite" style:UIBarButtonItemStyleBordered target:self  action:@selector(showInvite)];
    self.navigationItem.rightBarButtonItem = inviteButton;
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

#pragma ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    
//    NSLog(@"Images %@",info);
//    
//    //Save Images to DB
//    //Push Group Name
//    NameGroupViewController  *cvc = [[NameGroupViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    cvc.photos = info;
//    [controller pushViewController:cvc animated:YES];
    
    
    
    
}
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

#pragma GridViewController


-(void)showPhoto:(id)sender{
    
    UIButton *b = (UIButton*)sender;
    UIImage *image = b.imageView.image;
    
    PhotoViewController *pvc = [[PhotoViewController alloc] initWithImage:image];
    [self.navigationController pushViewController:pvc animated:YES];

}

- (void)showInvite{

    InviteViewController *ivc = [[InviteViewController alloc] initWithGroup:self.group];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ivc];
    [self.navigationController presentModalViewController:nav animated:YES];

}
- (void)showUpload{

    ELCAlbumPickerController *avc = [[ELCAlbumPickerController alloc] initWithStyle:UITableViewStyleGrouped];
    ELCImagePickerController *controller  = [[ELCImagePickerController alloc] initWithRootViewController:avc];
    [avc setParent:controller];  
    [controller setDelegate:self];
    [self presentModalViewController:controller animated:YES];
    
    
}

@end
