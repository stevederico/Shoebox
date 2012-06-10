//
//  SDDataManager.m
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import "SDDataManager.h"

@implementation SDDataManager

- (void)monitor{
    
    SSManagedObjectContextObserver *observer = [[SSManagedObjectContextObserver alloc] init];
//    observer.entity = [Photo entity];
    observer.observationBlock = ^(NSSet *insertedObjects, NSSet *updatedObjects) {
        NSLog(@"Inserted %i items. Updated %i items.", insertedObjects.count, updatedObjects.count);
        //Update Parse
    };
    
    [[SSManagedObject mainContext] addObjectObserver:observer];
    
}

- (void)writePhotosWithArray:(NSArray*)photos andGroupName:(NSString*)name{

//    //Get Current User
//    User *user = [self currentUser];
//    
//    //Create Group
//    Group *group = [[Group alloc] initWithEntity:[Group entityWithContext:[SSManagedObject mainContext]] insertIntoManagedObjectContext:[SSManagedObject mainContext]];
//    group.name = name;
//    [group addUsersObject:user];
//    
//    
//    //Create Photos
//    for (NSDictionary *dict in photos) {
//        Photo *photo = [[Photo alloc] initWithEntity:[Photo entityWithContext:[SSManagedObject mainContext]] insertIntoManagedObjectContext:[SSManagedObject mainContext]];
//        photo.path = [[dict objectForKey:@"UIImagePickerControllerReferenceURL"] absoluteString];
//        photo.owner = user;
//        photo.group = group;
//    }
//    
//    [[SSManagedObject mainContext] save:nil];
    
    //PARSE
    
    //Create Group
    PFObject *group = [PFObject objectWithClassName:@"Group"];
    [group setValue:name forKey:@"Name"];
    [group setValue:@"ME" forKey:@"User"];
    PFRelation *relation = [group relationforKey:@"Photos"];
    [group save];
    
    for (NSDictionary *dict in photos) {
        PFObject *photo = [PFObject objectWithClassName:@"Photo"];
        [photo setValue:@"ME" forKey:@"Owner"];
        [photo setValue:group forKey:@"Group"];
   
        ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
        [assetLibrary assetForURL:[dict objectForKey:@"UIImagePickerControllerReferenceURL"] resultBlock:^(ALAsset *asset) 
         {
             ALAssetRepresentation *rep = [asset defaultRepresentation];
             Byte *buffer = (Byte*)malloc(rep.size);
             NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
             NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];//this is NSData may be what you want
//           [data writeToFile:photoFile atomically:YES];//you can save image later
             
             PFFile *file = [PFFile fileWithName:@"photo.png" data:data];
             [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                     [photo setValue:file forKey:@"file"];
                 
                    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                     [relation addObject:photo];
                    }];

             }];
         
             
         } 
        failureBlock:^(NSError *err) {
                NSLog(@"Error: %@",[err localizedDescription]);
        }];
    
        
    }
    
 
    

}

- (User*)currentUser{

    User *user = [[User alloc] initWithEntity:[User entityWithContext:[User mainContext]] insertIntoManagedObjectContext:[User mainContext]];
    user.name = @"Steve Derico";
    
    return user;
}

@end
