//
//  Person+CoreDataProperties.h
//  ToDo
//
//  Created by Steve Graff on 5/5/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *assignment;
@property (nullable, nonatomic, retain) NSSet<Person *> *children;
@property (nullable, nonatomic, retain) Person *father;
@property (nullable, nonatomic, retain) Person *spouse;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addAssignmentObject:(NSManagedObject *)value;
- (void)removeAssignmentObject:(NSManagedObject *)value;
- (void)addAssignment:(NSSet<NSManagedObject *> *)values;
- (void)removeAssignment:(NSSet<NSManagedObject *> *)values;

- (void)addChildrenObject:(Person *)value;
- (void)removeChildrenObject:(Person *)value;
- (void)addChildren:(NSSet<Person *> *)values;
- (void)removeChildren:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END
