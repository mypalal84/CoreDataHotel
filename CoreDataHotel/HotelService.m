//
//  HotelService.m
//  CoreDataHotel
//
//  Created by A Cahn on 4/27/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import "HotelService.h"
#import "AppDelegate.h"
#import "BookViewController.h"
#import "RoomAvailabilityViewController.h"

@import Crashlytics;


@implementation HotelService

+ (void)saveReservationWithStartDate:(NSDate *)startDate
                             endDate:(NSDate *)endDate
                        selectedRoom:(Room *)selectedRoom
                           firstName:(NSString *)firstName
                            lastName:(NSString *)lastName
                               email:(NSString *)email{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    Reservation  *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
    
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = selectedRoom;
    
    selectedRoom.reservation = reservation;
    
    Guest *newGuest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
    
    reservation.guest = newGuest;
    
    newGuest.firstName = firstName;
    newGuest.lastName = lastName;
    newGuest.email = email;
    
    NSError *saveError;
    [context save:&saveError];
    
    if (saveError) {
        NSLog(@"Save error: %@", saveError);
        
        NSDictionary *attributesDictionary = @{@"Save Error" : saveError.localizedDescription};
        
        [Answers logCustomEventWithName:@"Save Reservation Error" customAttributes:attributesDictionary];
    } else {
        NSLog(@"Reservation saved successfully");
        
        [Answers logCustomEventWithName:@"Saved Reservation" customAttributes:nil];
    }
}


@end
