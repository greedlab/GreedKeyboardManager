//
//  UIScrollView+GRKeyboardManager.h
//  Pods
//
//  Created by Bell on 16/4/7.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRKeyboardManager.h"

@interface UIScrollView (GRKeyboardManager)

@property (nonatomic, strong, readonly) GRKeyboardManager *gr_keyboardManager;

@end
