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

    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        NSLog(@"portrait");
        [AutoLayout height:buttonHeight forView:browseButton];
        [AutoLayout leadingConstraintFrom:browseButton toView:self.view];
        [AutoLayout trailingConstraintFrom:browseButton toView:self.view];
        [AutoLayout topOffset:topAnchorHeight fromViewTop:browseButton toViewTop:self.view];
        
        [AutoLayout height:buttonHeight forView:bookButton];
        [AutoLayout leadingConstraintFrom:bookButton toView:self.view];
        [AutoLayout trailingConstraintFrom:bookButton toView:self.view];
        [AutoLayout topOffset:0 fromViewTop:bookButton toViewBottom:browseButton];
        
        [AutoLayout height:buttonHeight forView:lookupButton];
        [AutoLayout leadingConstraintFrom:lookupButton toView:self.view];
        [AutoLayout trailingConstraintFrom:lookupButton toView:self.view];
        [AutoLayout bottomConstraintFrom:lookupButton toView:self.view];
    }
    else if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        NSLog(@"landscape");
        [AutoLayout height:buttonHeight forView:browseButton];
        [AutoLayout leadingConstraintFrom:browseButton toView:self.view];
        [AutoLayout trailingConstraintFrom:browseButton toView:self.view];
        [AutoLayout topOffset:topAnchorHeight fromViewTop:browseButton toViewTop:self.view];
        
        [AutoLayout height:buttonHeight forView:bookButton];
        [AutoLayout leadingConstraintFrom:bookButton toView:self.view];
        [AutoLayout trailingConstraintFrom:bookButton toView:self.view];
        [AutoLayout topOffset:0 fromViewTop:bookButton toViewBottom:browseButton];
        
        [AutoLayout height:buttonHeight forView:lookupButton];
        [AutoLayout leadingConstraintFrom:lookupButton toView:self.view];
        [AutoLayout trailingConstraintFrom:lookupButton toView:self.view];
        [AutoLayout bottomConstraintFrom:lookupButton toView:self.view];
    }
    
    [browseButton addTarget:self action:@selector(browseButtonSelected) forControlEvents:UIControlEventTouchUpInside];

    [bookButton addTarget:self action:@selector(bookButtonSelected) forControlEvents:UIControlEventTouchUpInside];
}

-(void)browseButtonSelected{

    HotelsViewController *hotelsVC                 = [[HotelsViewController alloc]init];

    [self.navigationController pushViewController:hotelsVC animated:YES];

}

-(void)bookButtonSelected{

    DatePickerViewController *datePickerController = [[DatePickerViewController alloc]init];

    [self.navigationController pushViewController:datePickerController animated:YES];

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
