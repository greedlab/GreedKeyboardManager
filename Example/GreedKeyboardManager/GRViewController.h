//
//  GRViewController.h
//  GreedKeyboardManager
//
//  Created by Bell on 04/05/2016.
//  Copyright (c) 2016 greedlab. All rights reserved.
//

@import UIKit;
#import "UIScrollView+GRKeyboardManager.h"

@interface GRViewController : UIViewController<GRKeyboardManagerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *cancelButton;

@end
