//
//  Photo.h
//  Shoebox
//
//  Created by Stephen Derico on 6/3/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Group, User;

@interface Photo : SSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) User *owner;
@property (nonatomic, retain) Group *group;

@end
