//
//  GRKeyboardManager.h
//  Pods
//
//  Created by Bell on 16/4/5.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRKeyboardManager : NSObject

@property (nonatomic, weak) UIScrollView *scrollView;

/**
 *  weather enable GRKeyboardManager
 *  default YES
 */
@property (nonatomic, assign) BOOL enable;

/**
 *  default 10.f
 */
@property (nonatomic, assign) CGFloat textViewTopSpace;

/**
 *  default 10.f
 */
@property (nonatomic, assign) CGFloat textViewBottomSpace;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end
