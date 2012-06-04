//
//  Photo.h
//  Shoebox
//
//  Created by Stephen Derico on 6/4/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Group, User;

@interface Photo : SSManagedObject

@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) Group *group;
@property (nonatomic, retain) User *owner;

@end
