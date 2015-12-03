//
//  HotelsManagerTests.m
//  HotelsManagerTests
//
//  Created by Heidi Yee on 12/2/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataStack.h"

@interface HotelManagerTests : XCTestCase

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation HotelManagerTests

- (void)setUp {
    [super setUp];
    [self setContext:[[CoreDataStack sharedCoreDataStack]managedObjectContext]];
}

- (void)tearDown {
    [self setContext:nil];
    [super tearDown];
}

- (void)testContextCreation {
    XCTAssertNotNil(self.context, @"Context should not be nil. Check category implementation.");
}

- (void)testContextOnMainQ {
    XCTAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Context should be created on the main Q. Why did you change it?");
}

- (void)testCoreDataSave {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    request.resultType = NSCountResultType;
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    NSNumber *count = [result firstObject];
    
    XCTAssertNil(error, @"Error should be nil.");
    XCTAssertNotNil(result, @"Result array should NOT be nil.");
    XCTAssertTrue([count intValue] > 0, @"Number of objects in the database after seeding should be greater then 0.");
}

@end
