//
//  RoomsViewController.h
//  CoreDataHotel
//
//  Created by A Cahn on 4/24/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

@interface RoomsViewController : UIViewController

@property(strong, nonatomic)Hotel *selectedHotel;

@end
