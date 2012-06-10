//
//  CreateGroupViewController.m
//  Shoebox
//
//  Created by Stephen Derico on 6/3/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import "NameGroupViewController.h"

@interface NameGroupViewController ()

@end

@implementation NameGroupViewController
@synthesize photos;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Name Group";
                [self.tableView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = next;
    
  
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SDPlaceholderCell *cell = (SDPlaceholderCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SDPlaceholderCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    [[cell textField] setPlaceholder:@"Group Name"];
    [[cell textField] becomeFirstResponder];
    return cell;
}


- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
 
    SDFooterButtonView *footer = [[SDFooterButtonView alloc] initWithStyle:SDFooterButtonStyleGray];
    [footer.button setTitle:@"Invite Friends" forState:UIControlStateNormal];
    [footer.button addTarget:self action:@selector(showInvite) forControlEvents:UIControlEventTouchUpInside];
    
    
    return footer;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 70.0f;

}

- (void)showInvite{
 
    if (![self checkGroupName]) {
        return;
    }
        
    NSLog(@"Show Invite Screen");
//    InviteViewController *invite = [[InviteViewController alloc] initWithNibName:@"InviteViewController" bundle:nil];
//    [self.navigationController pushViewController:invite animated:YES];
    
}


- (void)close{    
    
    if ([self checkGroupName]) {
        [self dismissModalViewControllerAnimated:YES];
    }
    
}


- (BOOL)checkGroupName{

    SDPlaceholderCell *pc = (SDPlaceholderCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *groupName = [[pc textField] text];
    
    if (groupName.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter Group Name" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return false;
    }
    
    //Create Photos
    SDDataManager *dm = [[SDDataManager alloc] init];
    [dm writePhotosWithArray:self.photos andGroupName:groupName];
    
    return true;

}

@end
