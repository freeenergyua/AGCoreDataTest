//
//  Courses+CoreDataProperties.h
//  AGCoreDataTest
//
//  Created by AG on 11/25/15.
//  Copyright © 2015 AG. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Courses.h"
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Courses (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) University *university;
@property (nullable, nonatomic, retain) NSSet<Student *> *students;

@end

@interface Courses (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet<Student *> *)values;
- (void)removeStudents:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
