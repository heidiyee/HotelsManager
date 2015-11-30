//
//  Room+CoreDataProperties.h
//  HotelsManager
//
//  Created by Heidi Yee on 11/30/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Room.h"
#import "Hotel.h"
#import "Reservation.h"

NS_ASSUME_NONNULL_BEGIN

@interface Room (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *beds;
@property (nullable, nonatomic, retain) NSNumber *roomNumber;
@property (nullable, nonatomic, retain) NSNumber *priceRate;
@property (nullable, nonatomic, retain) Hotel *hotel;
@property (nullable, nonatomic, retain) Reservation *reservation;

@end

NS_ASSUME_NONNULL_END
