//
//  Student+CoreDataProperties.h
//  AGCoreDataTest
//
//  Created by AG on 11/25/15.
//  Copyright © 2015 AG. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) NSManagedObject *car;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *courses;
@property (nullable, nonatomic, retain) University *university;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(NSManagedObject *)value;
- (void)removeCoursesObject:(NSManagedObject *)value;
- (void)addCourses:(NSSet<NSManagedObject *> *)values;
- (void)removeCourses:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
