//
//  UIScrollView+GRKeyboardManager.m
//  Pods
//
//  Created by Bell on 16/4/7.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import "UIScrollView+GRKeyboardManager.h"
#import <objc/runtime.h>

@implementation UIScrollView (GRKeyboardManager)

#pragma mark - getter

- (GRKeyboardManager *)gr_keyboardManager {
    GRKeyboardManager *keyboardManager = objc_getAssociatedObject(self, _cmd);
    if (!keyboardManager) {
        keyboardManager = [[GRKeyboardManager alloc] init];
        keyboardManager.scrollView = self;
        objc_setAssociatedObject(self, _cmd, keyboardManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return keyboardManager;
}

@end
