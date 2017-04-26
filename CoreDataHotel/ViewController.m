//
//  ViewController.m
//  CoreDataHotel
//
//  Created by A Cahn on 4/24/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import "ViewController.h"
#import "AutoLayout.h"
#import "HotelsViewController.h"
#import "DatePickerViewController.h"
#import "LookupReservationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView{
    [super loadView];

    self.view.backgroundColor                      = [UIColor whiteColor];

    [self setupLayout];
}

-(void)setupLayout{

    CGFloat navBarHeight                           = CGRectGetHeight(self.navigationController.navigationBar.frame);//navbar height is 44
    CGFloat statusBarHeight                        = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat topAnchorHeight                        = navBarHeight + statusBarHeight;
    CGFloat viewHeight                             = self.view.bounds.size.height - topAnchorHeight;
    CGFloat buttonHeight                           = viewHeight / 3;

    UIButton *browseButton                         = [self createButtonWithTitle:@"Browse"];
    UIButton *bookButton                           = [self createButtonWithTitle:@"Book"];
    UIButton *lookupButton                         = [self createButtonWithTitle:@"Look Up"];

    browseButton.backgroundColor                   = [UIColor colorWithRed:0.91 green:0.81 blue:0.03 alpha:1.0];

    bookButton.backgroundColor                     = [UIColor colorWithRed:0.03 green:0.85 blue:0.96 alpha:1.0];

    lookupButton.backgroundColor                   = [UIColor colorWithRed:0.89 green:0.53 blue:0.63 alpha:1.0];

   
    
    [AutoLayout leadingConstraintFrom:browseButton toView:self.view];
    [AutoLayout trailingConstraintFrom:browseButton toView:self.view];
    [AutoLayout offset:0 fromViewTop:browseButton toViewBottom:self.topLayoutGuide];
    
    [AutoLayout leadingConstraintFrom:bookButton toView:self.view];
    [AutoLayout trailingConstraintFrom:bookButton toView:self.view];
    [AutoLayout offset:0 fromViewTop:bookButton toViewBottom:browseButton];
    [AutoLayout equalHeightConstraintFromView:browseButton toView:bookButton withMultiplier:1.0];
    
    [AutoLayout leadingConstraintFrom:lookupButton toView:self.view];
    [AutoLayout trailingConstraintFrom:lookupButton toView:self.view];
    [AutoLayout bottomConstraintFrom:lookupButton toView:self.view];
    [AutoLayout offset:0 fromViewTop:lookupButton toViewBottom:bookButton];
    [AutoLayout equalHeightConstraintFromView:bookButton toView:lookupButton withMultiplier:1.0];
    
    
    
    [browseButton addTarget:self action:@selector(browseButtonSelected) forControlEvents:UIControlEventTouchUpInside];

    [bookButton addTarget:self action:@selector(bookButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    
    [lookupButton addTarget:self action:@selector(lookupButtonSelected) forControlEvents:UIControlEventTouchUpInside];
}

-(void)browseButtonSelected{

    HotelsViewController *hotelsVC                 = [[HotelsViewController alloc]init];

    [self.navigationController pushViewController:hotelsVC animated:YES];

}

-(void)bookButtonSelected{

    DatePickerViewController *datePickerController = [[DatePickerViewController alloc]init];

    [self.navigationController pushViewController:datePickerController animated:YES];

}

-(void)lookupButtonSelected{
    
    LookupReservationViewController *lookupReservationController = [[LookupReservationViewController alloc]init];
    
    [self.navigationController pushViewController:lookupReservationController animated:YES];
    
}

-(UIButton *)createButtonWithTitle:(NSString *)title{

    UIButton *button                               = [[UIButton alloc]init];

    [button setTitle:title forState:normal];

    [button setTitleColor:[UIColor blackColor] forState:normal];

    [button setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.view addSubview:button];

    return button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
