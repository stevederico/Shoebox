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
    PFRelation *relation = [group relationforKey:@"Photos"];
    [group save];
    __block int i = 1;
    for (NSDictionary *dict in photos) {
        
        NSLog(@"Dict %@",dict);
        
        PFObject *photo = [PFObject objectWithClassName:@"Photo"];
        [photo setValue:@"ME" forKey:@"Owner"];
        [photo setValue:group forKey:@"Group"];
        
        UIImage *image = [dict objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data = UIImagePNGRepresentation(image);
        
        PFFile *file = [PFFile fileWithName:[NSString stringWithFormat:@"%@-%d.png",[group valueForKey:@"Name"],i] data:data];
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [photo setValue:file forKey:@"file"];
            
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
             NSString *baseDocumentPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
             NSString *extension = [NSString stringWithFormat:@"%@-%d.png",[group valueForKey:@"Name"],i];
       
             [data writeToFile:[baseDocumentPath stringByAppendingPathComponent:extension] 
                    atomically:YES];
       
            
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [relation addObject:photo];
            }];
            
        }];
             i++;
        
}
    
 
    

}



@end
