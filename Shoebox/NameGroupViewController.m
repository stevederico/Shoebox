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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Name Group";
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
 
    NSLog(@"Show Invite Screen");
    InviteViewController *invite = [[InviteViewController alloc] initWithNibName:@"InviteViewController" bundle:nil];
    [self.navigationController pushViewController:invite animated:YES];
    
}


- (void)close{
 
    [self dismissModalViewControllerAnimated:YES];
    
}


@end
