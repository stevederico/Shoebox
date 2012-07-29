//
//  SignUpViewController.m
//  Shoebox
//
//  Created by Steve Derico on 7/29/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize passwordField;
@synthesize emailField;


-(id)init{

    self = [super init];
    if (self) {
        // Custom initialization
        
        self.emailField.delegate = self;
        self.passwordField.delegate = self;
        
    }
    return self;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.emailField.delegate = self;
        self.passwordField.delegate = self;
        
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
    [self setPasswordField:nil];
    [self setEmailField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)SignUp:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.emailField.text;
    user.password = self.passwordField.text;
    user.email = self.emailField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            NSLog(@"Signed Up!");
            
            [PFUser logInWithUsernameInBackground:user.username password:user.password
                                            block:^(PFUser *user, NSError *error) {
                                                if (user) {
                                                    // Do stuff after successful login.
                                                              NSLog(@"Logged In!");
                                                    [self dismissModalViewControllerAnimated:YES];
                                                    
                                                } else {
                                                    // The login failed. Check error to see why.
                                                      NSLog(@"Failed Login In");
                                                }
                                            }];
            
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            // Show the errorString somewhere and let the user try again.
            NSLog(@"%@",errorString);
        }
    }];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;

}
@end
