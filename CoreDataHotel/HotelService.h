//
//  HotelService.h
//  CoreDataHotel
//
//  Created by A Cahn on 4/27/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reservation+CoreDataProperties.h"
#import "Reservation+CoreDataProperties.m"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"


@interface HotelService : NSObject

+ (void)saveReservationWithStartDate:(NSDate *)startDate
                             endDate:(NSDate *)endDate
                        selectedRoom:(Room *)selectedRoom
                           firstName:(NSString *)firstName
                            lastName:(NSString *)lastName
                               email:(NSString *)email;

//+ (void)findAvailableRoomsWith


@end
