//
//  DatePickerViewController.m
//  CoreDataHotel
//
//  Created by A Cahn on 4/25/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import "DatePickerViewController.h"
#import "RoomAvailabilityViewController.h"
#import "AutoLayout.h"

@interface DatePickerViewController ()

@property(strong, nonatomic) UIDatePicker *startDate;
@property(strong, nonatomic) UIDatePicker *endDate;

@end

@implementation DatePickerViewController

-(void)loadView{
    [super loadView];

    [self setupDatePickers];
    
    [self setupDoneButton];

    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupDatePickers{
    
    self.endDate                = [[UIDatePicker alloc]init];
    
    self.endDate.datePickerMode = UIDatePickerModeDate;
    
    //need to apply constraints here for lab
    
    
    self.endDate.frame          = CGRectMake(0, 84.0, self.view.frame.size.width, 200.0);
    
    [self.view addSubview:self.endDate];
    
}

//finish this for lab
-(void)setupDoneButton{
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    
    [self.navigationItem setRightBarButtonItem:doneButton];
    
}

-(void)doneButtonPressed{
    
    NSDate *endDate = self.endDate.date;
    
    if ([[NSDate date] timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        //explore this during lab, can disable going to a date before today
        self.endDate.date = [NSDate date];
        return;
    }
    
    RoomAvailabilityViewController *availabilityController = [[RoomAvailabilityViewController alloc]init];
    
    availabilityController.endDate = endDate;
    
    [self.navigationController pushViewController:availabilityController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


@end
