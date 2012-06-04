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

    //Get Current User
    User *user = [self currentUser];
    
    //Create Group
    Group *group = [[Group alloc] initWithEntity:[Group entityWithContext:[SSManagedObject mainContext]] insertIntoManagedObjectContext:[SSManagedObject mainContext]];
    group.name = name;
    [group addUsersObject:user];
    
    
    //Create Photos
    for (NSDictionary *dict in photos) {
        Photo *photo = [[Photo alloc] initWithEntity:[Photo entityWithContext:[SSManagedObject mainContext]] insertIntoManagedObjectContext:[SSManagedObject mainContext]];
        photo.path = [[dict objectForKey:@"UIImagePickerControllerReferenceURL"] absoluteString];
        photo.owner = user;
        photo.group = group;
    }
    
    [[SSManagedObject mainContext] save:nil];

}

- (User*)currentUser{

    User *user = [[User alloc] initWithEntity:[User entityWithContext:[User mainContext]] insertIntoManagedObjectContext:[User mainContext]];
    user.name = @"Steve Derico";
    
    return user;
}

@end
