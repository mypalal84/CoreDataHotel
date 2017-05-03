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

@property(strong, nonatomic) UIDatePicker *startDatePicker;
@property(strong, nonatomic) UIDatePicker *endDatePicker;

@end

@implementation DatePickerViewController

-(void)loadView{
    [super loadView];

    [self setupDatePickers];
    [self setupDoneButton];
    [self setupLabels];

    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupLabels{

    UILabel *startDateLabel                                = [[UILabel alloc]init];
    UILabel *endDateLabel                                  = [[UILabel alloc]init];

    [self.view addSubview:startDateLabel];
    [self.view addSubview:endDateLabel];
    [startDateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [AutoLayout width:self.view.bounds.size.width forView:startDateLabel];
    [AutoLayout offset:0 fromViewTop:startDateLabel toViewBottom:self.topLayoutGuide];
    [AutoLayout height:30 forView:startDateLabel];
    [AutoLayout centerXFrom:startDateLabel toView:self.view withOffset:0];
//    self.startDatePicker.backgroundColor                   = [UIColor redColor];
    startDateLabel.text                                    = @"Start Date";
    startDateLabel.textAlignment                           = NSTextAlignmentCenter;

    [endDateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [AutoLayout width:self.view.bounds.size.width forView:endDateLabel];
    [AutoLayout offset:-10 fromViewTop:endDateLabel toViewTop:self.endDatePicker];
    [AutoLayout height:30 forView:endDateLabel];
    [AutoLayout centerXFrom:endDateLabel toView:self.view withOffset:0];
//    self.endDatePicker.backgroundColor                     = [UIColor greenColor];
    endDateLabel.text                                      = @"End Date";
    endDateLabel.textAlignment                             = NSTextAlignmentCenter;

}

-(void)setupDatePickers{

    self.startDatePicker                                   = [[UIDatePicker alloc]init];

    self.startDatePicker.datePickerMode                    = UIDatePickerModeDate;

    [self.view addSubview:self.startDatePicker];

    self.endDatePicker                                     = [[UIDatePicker alloc]init];

    self.endDatePicker.datePickerMode                      = UIDatePickerModeDate;

    [self.view addSubview:self.endDatePicker];
    [self.startDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.endDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];

    [AutoLayout leadingConstraintFrom:self.startDatePicker toView:self.view];
    [AutoLayout trailingConstraintFrom:self.startDatePicker toView:self.view];
    [AutoLayout offset:0 fromViewTop:self.startDatePicker toViewBottom:self.topLayoutGuide];
    [AutoLayout equalHeightConstraintFromView:self.startDatePicker toView:self.endDatePicker withMultiplier:1.0];


    //need to apply constraints here for lab
    [AutoLayout leadingConstraintFrom:self.endDatePicker toView:self.view];
    [AutoLayout trailingConstraintFrom:self.endDatePicker toView:self.view];
    [AutoLayout offset:15 fromViewTop:self.endDatePicker toViewBottom:self.startDatePicker];
    [AutoLayout offset:0 fromViewBottom:self.endDatePicker toViewBottom:self.view];
    

}

//finish this for lab
-(void)setupDoneButton{

    UIBarButtonItem *doneButton                            = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];

    [self.navigationItem setRightBarButtonItem:doneButton];

}

-(void)doneButtonPressed{



    RoomAvailabilityViewController *roomAvailabilityController = [[RoomAvailabilityViewController alloc]init];

    roomAvailabilityController.endDate                         = [self.endDatePicker date];
    roomAvailabilityController.startDate                       = [self.startDatePicker date];

    [self.navigationController pushViewController:roomAvailabilityController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.startDatePicker addTarget:self
                             action:@selector(dateChanged:)
                   forControlEvents:UIControlEventValueChanged];
}

- (void)dateChanged:(UIDatePicker *)sender{
    self.startDatePicker.minimumDate                       = [NSDate date];

    self.endDatePicker.minimumDate                         = [self.startDatePicker date];
    [self.endDatePicker setDate:[self.startDatePicker date]];
}


@end
