//
//  GridViewController.m
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "GridViewController.h"
#import "SDFooterButtonView.h"
@interface GridViewController ()

@end

@implementation GridViewController{
    SDFooterButtonView *footer;
}
@synthesize photos = _photos;
@synthesize group = _group;

- (id)initWithGroup:(PFObject*)group{

    self = [super init];
    if (self) {
        self.group = group;
        self.title = [group objectForKey:@"Name"];
        self.collectionView.rowSpacing = 5.0;

        
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
    
	// Do any additional setup after loading the view.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Photos" style:UIBarButtonItemStyleBordered target:self  action:@selector(showUpload)];
    self.navigationItem.rightBarButtonItem = addButton;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
                [self.collectionView reloadData];
                //                [self setupThumbs];
            }
            
        }
        
    }];
    
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


-(void)showPhoto:(UIImage*)_image{
    

    
    PhotoViewController *pvc = [[PhotoViewController alloc] initWithImage:_image];
//    [pvc setTitle:[NSString stringWithFormat:@"%d of %d",[sender tag],self.photos.count]];
    
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

#pragma mark - SSCollectionViewDataSource

- (NSUInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSUInteger)section {
	return self.photos.count;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    SSCollectionViewItem *cell = [self.collectionView dequeueReusableItemWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SSCollectionViewItem alloc] initWithStyle:SSCollectionViewItemStyleImage  reuseIdentifier:CellIdentifier];
        [cell.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [cell setClipsToBounds:YES];
    }
    
    PFObject *p = [self.photos objectAtIndex:indexPath.row];
    NSData *data = [[p objectForKey:@"file"] getData];
    UIImage *image = [UIImage imageWithData:data];
    cell.imageView.image = image;
    
    return cell;
}

- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *p = [self.photos objectAtIndex:indexPath.row];
    NSData *data = [[p objectForKey:@"file"] getData];
    UIImage *image = [UIImage imageWithData:data];
    [self showPhoto:image];
    

}


#pragma mark - SSCollectionViewDelegate

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSUInteger)section {
	return CGSizeMake(150.0f, 150.0f);
}


@end
