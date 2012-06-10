//
//  HomeViewController.m
//  Shoebox
//
//  Created by Stephen Derico on 6/3/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import "NameGroupViewController.h"
#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize groups;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Shoebox";

        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
     
        
   
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self  action: @selector(showCreateGroup)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setTranslucent:YES];

    
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.groups = objects;
            [self.tableView reloadData];
        if ([groups count]>0) {
            NSLog(@"TOTAL Groups %d",[groups count]);
            
        }
        
    }];
    
   
    


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[self.groups objectAtIndex:indexPath.row] objectForKey:@"Name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",[[[self.groups objectAtIndex:indexPath.row] objectForKey:@"Photos"] count]];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *g =  [self.groups objectAtIndex:indexPath.row];
    NSLog(@"Group %@",g);
    
    GridViewController *grid = [[GridViewController alloc] initWithGroup:g];
    [self.navigationController pushViewController:grid animated:YES];
    
}

- (void) showCreateGroup{

    ELCAlbumPickerController *avc = [[ELCAlbumPickerController alloc] initWithStyle:UITableViewStyleGrouped];
    controller  = [[ELCImagePickerController alloc] initWithRootViewController:avc];
    [avc setParent:controller];  
    [controller setDelegate:self];
    [self presentModalViewController:controller animated:YES];
    
}

#pragma ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    
    NSLog(@"Images %@",info);
    
    //Save Images to DB
    //Push Group Name
    NameGroupViewController  *cvc = [[NameGroupViewController alloc] initWithStyle:UITableViewStyleGrouped];
    cvc.photos = info;
    [controller pushViewController:cvc animated:YES];
    



}
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{

    [self dismissModalViewControllerAnimated:YES];
    
}


@end
