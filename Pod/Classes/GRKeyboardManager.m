//
//  GRKeyboardManager.m
//  Pods
//
//  Created by Bell on 16/4/5.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import "GRKeyboardManager.h"
#import "UIView+GRKeyboardManager.h"

@interface GRKeyboardManager ()

/**
 *  UITextField/UITextView object voa textField/textView notifications
 */
@property (nonatomic, weak) UIView *textView;

/**
 *  keyboard animation duration
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 *  keyboard frame
 */
@property (nonatomic, assign) CGRect keyboardFrame;

@end

@implementation GRKeyboardManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _enable = YES;
        _textViewTopSpace = 10.f;
        _textViewBottomSpace = 10.f;
        _keyboardFrame = CGRectZero;
        [self addObservers];
    }
    return self;
}

- (void)dealloc {
    [self removeObservers];
}

#pragma mark - public

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [self init];
    if (self) {
        self.scrollView = scrollView;
    }
    return self;
}

#pragma mark - UIKeyboad Notification

- (void)keyboardWillShow:(NSNotification *)notification {
}

- (void)keyboardWillHide:(NSNotification *)notification {
}

- (void)keyboardDidHide:(NSNotification *)notification {
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    //  Getting UIKeyboardSize.
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (CGRectEqualToRect(_keyboardFrame, keyboardFrame)) {
        return;
    }
    _keyboardFrame = keyboardFrame;
    _animationDuration = duration;
    [self adjustFrame];
}

- (void)textViewDidBeginEditing:(NSNotification *)notification {
    _textView = notification.object;
    [self adjustFrame];
}

- (void)textViewDidEndEditing:(NSNotification *)notification {
    _textView = nil;
}

- (void)willChangeStatusBarOrientation:(NSNotification *)notification {
    [self adjustFrame];
}

#pragma mark - private

- (void)adjustFrame {
    if (!_enable || !_textView || CGRectEqualToRect(_keyboardFrame, CGRectZero) || [_textView gr_isAlertViewTextField]) {
        return;
    }
    UIWindow *keyWindow = [self keyWindow];
    //  Converting Rectangle according to window bounds.
    CGRect scrollViewRect = [[_scrollView superview] convertRect:_scrollView.frame toView:keyWindow];
    CGFloat buttom = CGRectGetMaxY(scrollViewRect) - CGRectGetMinY(_keyboardFrame);
    UIEdgeInsets contentInset = _scrollView.contentInset;
    UIEdgeInsets scrollIndicatorInsets = _scrollView.scrollIndicatorInsets;
    contentInset.bottom = buttom;
    scrollIndicatorInsets.bottom = buttom;

    CGPoint contentOffset = _scrollView.contentOffset;
    if (buttom > 0 && [_textView gr_isSubviewToView:_scrollView]) {
        CGRect textViewRect = [[_textView superview] convertRect:_textView.frame toView:_scrollView];
        if (CGRectGetHeight(_textView.frame) > CGRectGetHeight(_scrollView.frame) - contentInset.top - contentInset.bottom) {
            contentOffset.y = CGRectGetMinY(textViewRect) - contentInset.top - _textViewTopSpace;
        } else if (contentOffset.y > CGRectGetMinY(textViewRect) - contentInset.top) {
            contentOffset.y = CGRectGetMinY(textViewRect) - contentInset.top - _textViewTopSpace;
        } else if (contentOffset.y < CGRectGetMaxY(textViewRect) - (CGRectGetHeight(_scrollView.frame) - contentInset.bottom)) {
            contentOffset.y = CGRectGetMaxY(textViewRect) - (CGRectGetHeight(_scrollView.frame) - contentInset.bottom) + _textViewBottomSpace;
        }
    }

    WeakSelf(weakSelf);
    [UIView animateWithDuration:_animationDuration
                     animations:^{
                         StrongSelf(strongSelf);
                         [strongSelf.scrollView setContentInset:contentInset];
                         [strongSelf.scrollView setScrollIndicatorInsets:scrollIndicatorInsets];
                         [strongSelf.scrollView setContentOffset:contentOffset];
                     }];
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willChangeStatusBarOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIWindow *)keyWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!window) {
        window = [[[UIApplication sharedApplication] windows] lastObject];
    }
    return window;
}

@end
