//
//  UIView+GRKeyboardManager.m
//  Pods
//
//  Created by Bell on 16/4/5.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import "UIView+GRKeyboardManager.h"

@implementation UIView (GRKeyboardManager)

- (BOOL)gr_isAlertViewTextField {
    return ([self isKindOfClass:NSClassFromString(@"UIAlertSheetTextField")] || [self isKindOfClass:NSClassFromString(@"_UIAlertControllerTextField")]);
}

- (BOOL)gr_isSubviewToView:(UIView *)view {
    UIView *superView = nil;
    do {
        superView = [self superview];
        if (superView && superView == view) {
            return YES;
        }
    } while (superView);
    return NO;
}

@end
