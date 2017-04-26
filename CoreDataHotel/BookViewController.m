//
//  BookViewController.m
//  CoreDataHotel
//
//  Created by A Cahn on 4/25/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import "BookViewController.h"

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
    
    UITextField *firstName = [[UITextField alloc]init];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


@end
