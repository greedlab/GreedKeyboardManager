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

@property (nonatomic, assign) UIEdgeInsets originContentInsets;
@property (nonatomic, assign) UIEdgeInsets originScrollIndicatorInsets;

@property (nonatomic, assign) BOOL showKeyboard;

@end

@implementation GRKeyboardManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _originContentInsets = UIEdgeInsetsZero;
        _showKeyboard = NO;
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
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (CGRectEqualToRect(_keyboardFrame, keyboardFrame)) {
        return;
    }
    if (!_showKeyboard) {
        self.originContentInsets = _scrollView.contentInset;
        self.originScrollIndicatorInsets = _scrollView.scrollIndicatorInsets;
    }
    _showKeyboard = YES;
    _keyboardFrame = keyboardFrame;
    _animationDuration = duration;
    if (_textView) {
        [self updateFrame];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (CGRectEqualToRect(_keyboardFrame, keyboardFrame)) {
        return;
    }
    _showKeyboard = NO;
    _keyboardFrame = keyboardFrame;
    _animationDuration = duration;
    [self updateFrame];
}

- (void)keyboardDidHide:(NSNotification *)notification {
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
}

- (void)textViewDidBeginEditing:(NSNotification *)notification {
    _textView = notification.object;
    if (_showKeyboard) {
        [self updateFrame];
    }
}

- (void)textViewDidEndEditing:(NSNotification *)notification {
    _textView = nil;
}

- (void)willChangeStatusBarOrientation:(NSNotification *)notification {
    if (_showKeyboard) {
        [self updateFrame];
    }
}

#pragma mark - private

- (void)updateFrame {
    if (!_enable || !_textView || CGRectEqualToRect(_keyboardFrame, CGRectZero) || [_textView gr_isAlertViewTextField]) {
        return;
    }
    UIEdgeInsets contentInset;
    UIEdgeInsets scrollIndicatorInsets;
    CGFloat buttom;
    if (_showKeyboard) {
        UIWindow *keyWindow = [self keyWindow];
        //  Converting Rectangle according to window bounds.
        CGRect scrollViewRect = [[_scrollView superview] convertRect:_scrollView.frame toView:keyWindow];
        buttom = CGRectGetMaxY(scrollViewRect) - CGRectGetMinY(_keyboardFrame);
        contentInset = _scrollView.contentInset;
        scrollIndicatorInsets = _scrollView.scrollIndicatorInsets;
        contentInset.bottom = buttom;
        scrollIndicatorInsets.bottom = buttom;
    } else {
        contentInset = _originContentInsets;
        scrollIndicatorInsets = _originContentInsets;
    }

    CGPoint contentOffset = _scrollView.contentOffset;
    if (_showKeyboard && [_textView gr_isSubviewToView:_scrollView]) {
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
