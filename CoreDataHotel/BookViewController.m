//
//  BookViewController.m
//  CoreDataHotel
//
//  Created by A Cahn on 4/25/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import "BookViewController.h"
#import "AutoLayout.h"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "AppDelegate.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"
#import "DatePickerViewController.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

@import Crashlytics;

@interface BookViewController ()

@property(strong, nonatomic)UITextField *firstNameTextField;
@property(strong, nonatomic)UITextField *lastNameTextField;
@property(strong, nonatomic)UITextField *emailTextField;

@end

@implementation BookViewController

-(void)loadView{
    [super loadView];
    
    [self setupBookViewController];
    
    [self setupTextFields];
    
    [self setupLabels];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupBookViewController{
    
    [self.navigationItem setTitle:self.selectedRoom.hotel.name];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)]];
    
}

-(void)setupLabels{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    
    UILabel *hotelLabel = [[UILabel alloc]init];
    [self.view addSubview:hotelLabel];
    [hotelLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    hotelLabel.text = [NSString stringWithFormat:@"Hotel: %@ Room - %i", self.selectedRoom.hotel.name, self.selectedRoom.number];
    [AutoLayout offset:10 fromViewTop:hotelLabel toViewBottom:self.emailTextField];
    [AutoLayout height:20 forView:hotelLabel];
    [AutoLayout centerXFrom:hotelLabel toView:self.view withOffset:0];
    
    UILabel *startDateLabel = [[UILabel alloc]init];
    [self.view addSubview:startDateLabel];
    [startDateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    startDateLabel.text = [NSString stringWithFormat:@"Check-In: %@", [dateFormatter stringFromDate:self.startDate]];
    [AutoLayout offset:10 fromViewTop:startDateLabel toViewBottom:hotelLabel];
    [AutoLayout height:20 forView:startDateLabel];
    [AutoLayout centerXFrom:startDateLabel toView:self.view withOffset:0];
    
    UILabel *endDateLabel = [[UILabel alloc]init];
    [self.view addSubview:endDateLabel];
    [endDateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    endDateLabel.text = [NSString stringWithFormat:@"Check-Out: %@", [dateFormatter stringFromDate:self.endDate]];
    [AutoLayout offset:10 fromViewTop:endDateLabel toViewBottom:startDateLabel];
    [AutoLayout height:20 forView:endDateLabel];
    [AutoLayout centerXFrom:endDateLabel toView:self.view withOffset:0];
}

-(void)setupTextFields{
    
    self.firstNameTextField             = [[UITextField alloc]init];
    self.lastNameTextField              = [[UITextField alloc]init];
    self.emailTextField                 = [[UITextField alloc]init];
    
    //    UIButton *bookButton                = [self createButtonWithTitle:@"Book"];
    //    self.firstNameTextField.backgroundColor = [UIColor yellowColor];
    //    self.lastNameTextField.backgroundColor = [UIColor redColor];
    //    self.emailTextField.backgroundColor = [UIColor blueColor];
    
    self.firstNameTextField.placeholder = @"First Name";
    self.lastNameTextField.placeholder  = @"Last Name";
    self.emailTextField.placeholder     = @"Email";
    
    [self.firstNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    
    [self.lastNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    
    [self.emailTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.firstNameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.lastNameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.emailTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.firstNameTextField];
    [self.view addSubview:self.lastNameTextField];
    [self.view addSubview:self.emailTextField];
    
    CGFloat topAnchorHeight = CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0;
    
    [AutoLayout offset:topAnchorHeight + 20 fromViewTop:self.firstNameTextField toViewTop:self.view];
    [AutoLayout height:60 forView:self.firstNameTextField];
    [AutoLayout width:360 forView:self.firstNameTextField];
    [AutoLayout centerXFrom:self.firstNameTextField toView:self.view withOffset:0];
    //    [AutoLayout topOffset:-100 fromViewTop:self.firstNameTextField toViewTop:self.lastNameTextField];
    
    [AutoLayout height:60 forView:self.lastNameTextField];
    [AutoLayout width:360 forView:self.lastNameTextField];
    [AutoLayout centerXFrom:self.lastNameTextField toView:self.view withOffset:0];
    [AutoLayout offset:80 fromViewTop:self.lastNameTextField toViewTop:self.firstNameTextField];
    //    [AutoLayout centerYFrom:self.lastNameTextField toView:self.view withOffset:0];
    
    [AutoLayout height:60 forView:self.emailTextField];
    [AutoLayout width:360 forView:self.emailTextField];
    [AutoLayout centerXFrom:self.emailTextField toView:self.view withOffset:0];
    [AutoLayout offset:80 fromViewTop:self.emailTextField toViewTop:self.lastNameTextField];
    
    [self.firstNameTextField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)saveButtonPressed:(UIBarButtonItem *)sender{
    AppDelegate *appDelegate            = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
    
    reservation.startDate = self.startDate;
    reservation.endDate = self.endDate;
    reservation.room = self.selectedRoom;
    
    self.selectedRoom.reservation = reservation;
    
    Guest *newGuest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
    
    reservation.guest = newGuest;
    
    newGuest.firstName                     = self.firstNameTextField.text;
    newGuest.lastName                      = self.lastNameTextField.text;
    newGuest.email                         = self.emailTextField.text;
    
    NSError *saveError;
    [context save:&saveError];
    
    if (saveError) {
        NSLog(@"Save error: %@", saveError);
        
        NSDictionary *attributesDictionary = @{@"Save Error" : saveError.localizedDescription};
        
        [Answers logCustomEventWithName:@"Save Reservation Error" customAttributes:attributesDictionary];
    } else {
        NSLog(@"Reservation saved successfully");
        
        [Answers logCustomEventWithName:@"Saved Reservation" customAttributes:nil];
                
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

@end
