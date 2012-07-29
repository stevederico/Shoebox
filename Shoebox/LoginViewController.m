//
//  LoginViewController.m
//  Shoebox
//
//  Created by Steve Derico on 7/29/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize emailTextField;
@synthesize passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
        self.navigationItem.leftBarButtonItem = cancel;
        
        UIBarButtonItem *signUpButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Up" style:UIBarButtonItemStyleDone target:self action:@selector(signup)];
        self.navigationItem.rightBarButtonItem = signUpButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setEmailTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)cancel{
    
    [self dismissModalViewControllerAnimated:YES];

}

- (void)signup{

    SignUpViewController *svc = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:svc animated:YES];

}

- (void)login{

    [PFUser logInWithUsernameInBackground:[self.emailTextField.text lowercaseString] password:[self.passwordTextField.text lowercaseString]
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self dismissModalViewControllerAnimated:YES];
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog(@"Failed Login");
                                        }
                                    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if (textField == self.passwordTextField) {
        [self login];
    }
    
    return YES;
}

@end
