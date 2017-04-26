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

@interface BookViewController ()

@property(strong, nonatomic)UITextField *firstNameTextField;
@property(strong, nonatomic)UITextField *lastNameTextField;
@property(strong, nonatomic)UITextField *emailTextField;

@end

@implementation BookViewController

-(void)loadView{
    [super loadView];

    [self setupTextFields];

    [self.view setBackgroundColor:[UIColor whiteColor]];
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

    [AutoLayout height:60 forView:self.firstNameTextField];
    [AutoLayout width:200 forView:self.firstNameTextField];
    [AutoLayout centerXFrom:self.firstNameTextField toView:self.view withOffset:0];
    [AutoLayout topOffset:-100 fromViewTop:self.firstNameTextField toViewTop:self.lastNameTextField];

    [AutoLayout height:60 forView:self.lastNameTextField];
    [AutoLayout width:200 forView:self.lastNameTextField];
    [AutoLayout centerXFrom:self.lastNameTextField toView:self.view withOffset:0];
    [AutoLayout centerYFrom:self.lastNameTextField toView:self.view withOffset:0];

    [AutoLayout height:60 forView:self.emailTextField];
    [AutoLayout width:200 forView:self.emailTextField];
    [AutoLayout centerXFrom:self.emailTextField toView:self.view withOffset:0];
    [AutoLayout topOffset:100 fromViewTop:self.emailTextField toViewTop:self.lastNameTextField];
    
    
//    [bookButton addTarget:self action:@selector(bookButtonSelected) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)bookButtonPressed{
    //TODO: Assign lastname, email to guest
    AppDelegate *appDelegate            = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
    
//    reservation.startDate = ;
//    reservation.endDate = ;
    reservation.room = self.selectedRoom;
    
    self.selectedRoom.reservation = reservation;
    

    Guest *guest                        = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:appDelegate.persistentContainer.viewContext];

    guest.firstName                     = self.firstNameTextField.text;
    guest.lastName                      = self.lastNameTextField.text;
    guest.email                         = self.emailTextField.text;
    
    reservation.guest = guest;
    
    NSError *saveError;
    [context save:&saveError];
    
    if (saveError) {
        NSLog(@"Error: %@", saveError);
    } else {
        NSLog(@"Reservation saved successfully");
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

@end
