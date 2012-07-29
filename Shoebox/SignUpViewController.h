//
//  SignUpViewController.h
//  Shoebox
//
//  Created by Steve Derico on 7/29/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>
- (IBAction)SignUp:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;

@end
