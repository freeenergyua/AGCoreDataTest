//
//  University+CoreDataProperties.h
//  AGCoreDataTest
//
//  Created by AG on 11/25/15.
//  Copyright © 2015 AG. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "University.h"

NS_ASSUME_NONNULL_BEGIN

@interface University (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *courses;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *students;

@end

@interface University (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(NSManagedObject *)value;
- (void)removeCoursesObject:(NSManagedObject *)value;
- (void)addCourses:(NSSet<NSManagedObject *> *)values;
- (void)removeCourses:(NSSet<NSManagedObject *> *)values;

- (void)addStudentsObject:(NSManagedObject *)value;
- (void)removeStudentsObject:(NSManagedObject *)value;
- (void)addStudents:(NSSet<NSManagedObject *> *)values;
- (void)removeStudents:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
