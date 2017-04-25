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

    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupDatePickers{
    CGFloat navBarHeight                           = CGRectGetHeight(self.navigationController.navigationBar.frame);//navbar height is 44
    CGFloat statusBarHeight                        = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat topAnchorHeight                        = navBarHeight + statusBarHeight;
    CGFloat viewHeight                             = self.view.bounds.size.height - topAnchorHeight;
    CGFloat datePickerHeight                       = viewHeight / 2;

    
    
    self.startDatePicker = [[UIDatePicker alloc]init];
    
    self.startDatePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.view addSubview:self.startDatePicker];
    
    self.endDatePicker                = [[UIDatePicker alloc]init];
    
    self.endDatePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.view addSubview:self.endDatePicker];
    
    [AutoLayout height:datePickerHeight forView:self.startDatePicker];
    [AutoLayout width:self.view.bounds.size.width forView:self.startDatePicker];
    [AutoLayout topOffset:topAnchorHeight fromViewTop:self.startDatePicker toViewTop:self.view];
    
    [self.startDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //need to apply constraints here for lab
    [AutoLayout height:datePickerHeight forView:self.endDatePicker];
    [AutoLayout width:self.view.bounds.size.width forView:self.endDatePicker];
    [AutoLayout topOffset:-30.0 fromViewTop:self.endDatePicker toViewBottom:self.startDatePicker];
    
    [self.endDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}

//finish this for lab
-(void)setupDoneButton{
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    
    [self.navigationItem setRightBarButtonItem:doneButton];
    
}

-(void)doneButtonPressed{
    
    
    
    RoomAvailabilityViewController *availabilityController = [[RoomAvailabilityViewController alloc]init];
    
    availabilityController.endDate = [self.endDatePicker date];
    availabilityController.startDate = [self.startDatePicker date];
    
    [self.navigationController pushViewController:availabilityController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.startDatePicker addTarget:self
                             action:@selector(dateChanged:)
                   forControlEvents:UIControlEventValueChanged];
}

- (void)dateChanged:(UIDatePicker *)sender{
    self.startDatePicker.minimumDate = [NSDate date];
    
    self.endDatePicker.minimumDate = [self.startDatePicker date];
    [self.endDatePicker setDate:[self.startDatePicker date]];
}


@end
