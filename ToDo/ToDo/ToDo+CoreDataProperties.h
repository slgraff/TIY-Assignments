//
//  ToDo+CoreDataProperties.h
//  ToDo
//
//  Created by Steve Graff on 5/5/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) NSNumber *done;
@property (nullable, nonatomic, retain) NSDate *timestamp;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) Person *assignee;

@end

NS_ASSUME_NONNULL_END
