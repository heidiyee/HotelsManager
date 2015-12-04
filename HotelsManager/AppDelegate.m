//
//  AppDelegate.m
//  HotelsManager
//
//  Created by Heidi Yee on 11/30/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataStack.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>



@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupRootViewController];
    [self bootstrapApp];
    [Fabric with:@[[Crashlytics class]]];
    [Fabric with:@[[Answers class]]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[CoreDataStack sharedCoreDataStack]saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[CoreDataStack sharedCoreDataStack]saveContext];
}


- (void)setupRootViewController {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.viewController = [[ViewController alloc]init];
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    self.viewController.view.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
}

- (void)bootstrapApp {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    NSError *error;
    NSInteger count = [[CoreDataStack sharedCoreDataStack].managedObjectContext countForFetchRequest:request error:&error];
    
    if (count == 0) {
        NSDictionary *hotels = [NSDictionary new];
        NSDictionary *rooms = [NSDictionary new];
        
        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"hotels" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        
        NSError *jsonError;
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Not able to serialize json file"); return;
        }
        
        hotels = rootObject[@"Hotels"];
        for (NSDictionary *hotel in hotels) {
            Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:[[CoreDataStack sharedCoreDataStack]managedObjectContext]];
            newHotel.name = hotel[@"name"];
            newHotel.location = hotel[@"location"];
            newHotel.stars = hotel[@"stars"];
            
            rooms = hotel[@"rooms"];
            for (NSDictionary *room in rooms) {
                Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:[[CoreDataStack sharedCoreDataStack]managedObjectContext]];
                newRoom.roomNumber = room[@"number"];
                newRoom.beds = room[@"beds"];
                newRoom.priceRate = room[@"rate"];
                newRoom.hotel = newHotel;
            }
        }
        
        NSError *saveError;
        BOOL isSaved = [[[CoreDataStack sharedCoreDataStack]managedObjectContext] save:&saveError];
        
        if (isSaved) {
            NSLog(@"Saved");
        } else {
            NSLog(@"%@", saveError.description);
        }
    }
}


@end
