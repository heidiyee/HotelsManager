//
//  Reservation.h
//  HotelsManager
//
//  Created by Heidi Yee on 11/30/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

NS_ASSUME_NONNULL_BEGIN

@interface Reservation : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Reservation+CoreDataProperties.h"
