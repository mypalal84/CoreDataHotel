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

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupLayout];
}

-(void)setupLayout{
    
//    float navBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);//navbar height is 44
    
    
    UIButton *browseButton = [self createButtonWithTitle:@"Browse"];
    UIButton *bookButton = [self createButtonWithTitle:@"Book"];
    UIButton *lookupButton = [self createButtonWithTitle:@"Look Up"];
    
    browseButton.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.75 alpha:1.0];
    
    [AutoLayout leadingConstraintFrom:browseButton toView:self.view];
    [AutoLayout trailingConstraintFrom:browseButton toView:self.view];
    
//    [AutoLayout topConstraintFrom:browseButton toView:self.view.bounds.size.height -44];
//    [AutoLayout bottomConstraintFrom:browseButton toView:self.view];
    NSLayoutConstraint *browseHeight = [AutoLayout equalHeightConstraintFromView:browseButton toView:self.view withMultiplier:0.33];
    
    
    
    [browseButton addTarget:self action:@selector(browseButtonSelected) forControlEvents:UIControlEventTouchUpInside];
}

-(void)browseButtonSelected{
    
    HotelsViewController *hotelsVC = [[HotelsViewController alloc]init];
    
    [self.navigationController pushViewController:hotelsVC animated:YES];
    
}

-(UIButton *)createButtonWithTitle:(NSString *)title{
    
    UIButton *button = [[UIButton alloc]init];
    
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
