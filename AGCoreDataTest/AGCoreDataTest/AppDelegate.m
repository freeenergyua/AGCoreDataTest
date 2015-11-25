//
//  AppDelegate.m
//  AGCoreDataTest
//
//  Created by AG on 11/25/15.
//  Copyright © 2015 AG. All rights reserved.
//

#import "AppDelegate.h"
#import "Car.h"
#import "Courses.h"
#import "University.h"
#import "Student.h"
#import "AGObject.h"
#import <CoreData/CoreData.h>

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* carModelNames[] = {
    @"ZAZ", @"Toyota", @"BMW", @"Lada", @"Volga"
};

@interface AppDelegate ()

@end

@implementation AppDelegate

- (Student*) addRandomStudent {
    
    Student* student =
    [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                  inManagedObjectContext:self.managedObjectContext];
    
    student.score = @((float)arc4random_uniform(201) / 200.f + 2.f);
    student.name = firstNames[arc4random_uniform(50)];
    student.age = @((float)arc4random_uniform(25)/5.f + 18.f);
    
    return student;
}

- (University*) addUniversity {
    
    University* university =
    [NSEntityDescription insertNewObjectForEntityForName:@"University"
                                  inManagedObjectContext:self.managedObjectContext];
    university.name = @"KNTEU";
    
    return university;
}

- (NSArray*) allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"AGObject"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}
- (Car*) addRandomCar {
    
    Car* car =
    [NSEntityDescription insertNewObjectForEntityForName:@"Car"
                                  inManagedObjectContext:self.managedObjectContext];
    car.model = carModelNames[arc4random_uniform(5)];
    
    return car;
}

- (void) printAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    for (id object in allObjects) {
        
        if ([object isKindOfClass:[Car class]]) {
            
            Car* car = (Car*) object;
            NSLog(@"CAR: %@, OWNER: %@ %@", car.model, car.owner.name, car.owner.age);
            
        } else if ([object isKindOfClass:[Student class]]) {
            
            Student* student = (Student*) object;
            NSLog(@"STUDENT: %@ %@, CAR %@ and  UNIVERSITY: %@",
                  student.name, student.age,student.car, student.university.name);
            
        } else if ([object isKindOfClass:[University class]]) {
            
            University* university = (University*) object;
            NSLog(@"UNIVERSITY: %@ Students: %lu", university.name, [university.students count]);
        }
        
        //NSLog(@"%@", object);
    }
}

- (void) deleteAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    for (id object in allObjects) {
        [self.managedObjectContext deleteObject:object];
    }
    [self.managedObjectContext save:nil];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSError* error = nil;
    
    University* university = [self addUniversity];
    
    for (int i = 0; i < 30; i++) {
        
        Student* student = [self addRandomStudent];
        
        if (arc4random_uniform(1000) < 500) {
            Car* car = [self addRandomCar];
            student.car = car;
        }
        
        student.university = university;
        
       // [university addStudentsObject:student];
    }
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [self printAllObjects];
    
    
    /* теперь удаляем университет который привязан к студентам каскадным delete rule и как результат сносит всех студентов а также собственникаов автомобилей но оставляет сами авто, так как у них delete rule = nullify */
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"University"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if ([resultArray count] > 0) {
        
        University* university = [resultArray firstObject];
        
        NSLog(@"university to delete %@", university);
        
        [self.managedObjectContext deleteObject:university];
        [self.managedObjectContext save:nil];
    }
    
    [self printAllObjects];
    
    [self deleteAllObjects];
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
//   очистка данных после отображения    ~~~~~~~~ D_E_L_E_T_E ~~~~~
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.AGCoreDataTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AGCoreDataTest" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataTest.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
