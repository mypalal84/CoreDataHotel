//
//  AutoLayout.h
//  CoreDataHotel
//
//  Created by A Cahn on 4/24/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

@import UIKit;

@interface AutoLayout : NSObject

+(NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                      toView:(UIView *)superView
                               withAttribute:(NSLayoutAttribute)attribute
                               andMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                      toView:(UIView *)superView
                               withAttribute:(NSLayoutAttribute)attribute;

+(NSArray *)fullScreeenConstraintsWithVFLForView:(UIView *)view;

+(NSLayoutConstraint *)equalHeightConstraintFromView:(UIView *)view
                                              toView:(UIView *)otherView
                                      withMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)leadingConstraintFrom:(UIView *)view
                                       toView:(UIView *)otherView;

+(NSLayoutConstraint *)trailingConstraintFrom:(UIView *)view
                                       toView:(UIView *)otherView;

+(NSLayoutConstraint *)topConstraintFrom:(UIView *)view
                                      toView:(UIView *)otherView;

+(NSLayoutConstraint *)bottomConstraintFrom:(UIView *)view
                                       toView:(UIView *)otherView;

+(NSLayoutConstraint *)width:(CGFloat)width forView:(UIView *)view;

+(NSLayoutConstraint *)height:(CGFloat)height forView:(UIView *)view;

+(NSLayoutConstraint *)centerXFrom:(UIView *)view toView:(UIView *)otherView withOffset:(CGFloat)offset;

+(NSLayoutConstraint *)centerYFrom:(UIView *)view toView:(UIView *)otherView withOffset:(CGFloat)offset;

+ (NSLayoutConstraint *)offset:(CGFloat)offset fromViewTop:(id)view toViewBottom:(id)otherView;

+ (NSLayoutConstraint *)offset:(CGFloat)offset fromViewTop:(id)view toViewTop:(id)otherView;

+ (NSLayoutConstraint *)offset:(CGFloat)offset fromViewBottom:(id)view toViewTop:(id)otherView;

+ (NSLayoutConstraint *)offset:(CGFloat)offset fromViewBottom:(id)view toViewBottom:(id)otherView;

@end
