//
//  SDDataManager.m
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import "SDDataManager.h"

@implementation SDDataManager

- (void)writePhotosWithArray:(NSArray*)photos andGroupName:(NSString*)name{

    //Create Group
    PFObject *group = [PFObject objectWithClassName:@"Group"];
    [group setValue:name forKey:@"Name"];
    [group setValue:@"ME" forKey:@"User"];
    group.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
    PFRelation *relation = [group relationforKey:@"Photos"];
    [group save];

    for (NSDictionary *dict in photos) {
        
        NSLog(@"Dict %@",dict);
        
        PFObject *photo = [PFObject objectWithClassName:@"Photo"];
        [photo setValue:@"ME" forKey:@"Owner"];
        [photo setValue:group forKey:@"Group"];
        
        UIImage *image = [dict objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data = UIImagePNGRepresentation(image);
        
        PFFile *file = [PFFile fileWithName:[NSString stringWithFormat:@"%@.png",[group valueForKey:@"Name"]] data:data];
        
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [photo setValue:file forKey:@"file"];
            NSLog(@"Photo Done!");
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"PhotoDone" object:nil] ];
            
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                [relation addObject:photo];
                   [group save];
            }];
            
        } progressBlock:^(int percentDone) {
            if (percentDone == 100) {
               
            }
        }];

     
        
}

}

-(void)addPhotos:(NSArray*)photos ToGroup:(PFObject*)group{
    for (NSDictionary *dict in photos) {
         PFRelation *relation = [group relationforKey:@"Photos"];
        NSLog(@"Dict %@",dict);
        
        PFObject *photo = [PFObject objectWithClassName:@"Photo"];
        [photo setValue:[[PFUser currentUser] objectId] forKey:@"Owner"];
        [photo setValue:group forKey:@"Group"];
        
        UIImage *image = [dict objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data = UIImagePNGRepresentation(image);
        
        PFFile *file = [PFFile fileWithName:[NSString stringWithFormat:@"%@.png",[group valueForKey:@"Name"]] data:data];
        
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [photo setValue:file forKey:@"file"];
            NSLog(@"Photo Done!");
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"PhotoDone" object:nil] ];
            
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                [relation addObject:photo];
                [group saveInBackground];
            }];
            
        } progressBlock:^(int percentDone) {
            if (percentDone == 100) {
                
            }
        }];
        
        
    }
    

}
@end
