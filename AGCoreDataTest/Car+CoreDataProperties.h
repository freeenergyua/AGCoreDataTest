//
//  Car+CoreDataProperties.h
//  AGCoreDataTest
//
//  Created by AG on 11/25/15.
//  Copyright © 2015 AG. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface Car (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) Student *owner;

@end

NS_ASSUME_NONNULL_END
