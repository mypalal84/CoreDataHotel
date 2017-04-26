//
//  BookViewController.m
//  CoreDataHotel
//
//  Created by A Cahn on 4/25/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import "BookViewController.h"
#import "AutoLayout.h"

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
    
    self.firstNameTextField = [[UITextField alloc]init];
    self.lastNameTextField = [[UITextField alloc]init];
    self.emailTextField = [[UITextField alloc]init];
    
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
    [AutoLayout topOffset:140 fromViewTop:self.emailTextField toViewTop:self.lastNameTextField];

}

- (void)viewDidLoad {
    [super viewDidLoad];

}


@end
