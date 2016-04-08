//
//  GRKeyboardManager.h
//  Pods
//
//  Created by Bell on 16/4/5.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRKeyboardManager;

@protocol GRKeyboardManagerDelegate <NSObject>

@optional
- (void)keyboardManager:(GRKeyboardManager *)keyboardManager willShowWithDuration:(CGFloat)duration keyboardFrame:(CGRect)keyboardFrame;
- (void)keyboardManager:(GRKeyboardManager *)keyboardManager willHideWithDuration:(CGFloat)duration keyboardFrame:(CGRect)keyboardFrame;

@end

@interface GRKeyboardManager : NSObject

@property (nonatomic, weak) UIScrollView *scrollView;

/**
 *  whether enable GRKeyboardManager
 *  default YES
 */
@property (nonatomic, assign) BOOL enable;

/**
 *  min space between the top of texView and the top of scrollView when showing keyboard
 *  default 5.f
 */
@property (nonatomic, assign) CGFloat textViewTopSpace;

/**
 *  min space between the bottom of texView and the bottom of scrollView when showing keyboard
 *  default 5.f
 */
@property (nonatomic, assign) CGFloat textViewBottomSpace;

/**
 *  space between keyboard and the bottom of scrollview when showing keyboard
 *  default 0.f
 */
@property (nonatomic, assign) CGFloat scrollViewBottomSpace;

@property (nonatomic, weak) id<GRKeyboardManagerDelegate> delegate;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;
- (UIWindow *)keyWindow;

@end
