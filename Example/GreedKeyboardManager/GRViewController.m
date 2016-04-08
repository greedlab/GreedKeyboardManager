//
//  GRViewController.m
//  GreedKeyboardManager
//
//  Created by Bell on 04/05/2016.
//  Copyright (c) 2016 greedlab. All rights reserved.
//

#import "GRViewController.h"
#import <Masonry/Masonry.h>

const CGFloat kGRViewControllerToolViewHeight = 50.f;

@interface GRViewController () {
    MASConstraint *_toolViewBottomConstraint;
    CGFloat _toolViewBottomConstraintOffset;
}

@end

@implementation GRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initView];
    [self setConstraints];
    _scrollView.gr_keyboardManager.delegate = self;
    _scrollView.gr_keyboardManager.scrollViewBottomSpace = kGRViewControllerToolViewHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (void)cancelButtonPressed:(id)sender {
    [_textField resignFirstResponder];
    [_textView resignFirstResponder];
}

#pragma mark - GRKeyboardManagerDelegate

- (void)keyboardManager:(GRKeyboardManager*)keyboardManager willShowWithDuration:(CGFloat)duration keyboardFrame:(CGRect)keyboardFrame {
    UIWindow *keyWindow = [keyboardManager keyWindow];
    CGRect toolViewFrame = [[_toolView superview] convertRect:_toolView.frame toView:keyWindow];
    CGFloat offset = CGRectGetMinY(keyboardFrame) - CGRectGetMaxY(toolViewFrame);
//    NSLog(@"toolViewBottomConstraint offset:%f",offset);
    [_toolViewBottomConstraint setOffset:offset];
    WeakSelf(weakSelf);
    [UIView animateWithDuration:duration animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
}


- (void)keyboardManager:(GRKeyboardManager*)keyboardManager willHideWithDuration:(CGFloat)duration keyboardFrame:(CGRect)keyboardFrame {
    [_toolViewBottomConstraint setOffset:_toolViewBottomConstraintOffset];
    WeakSelf(weakSelf);
    [UIView animateWithDuration:duration animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
}

#pragma mark - private

- (void)initView {
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.toolView];
    [self.scrollView addSubview:self.bgView];
    [self.scrollView addSubview:self.textView];
    [self.scrollView addSubview:self.textField];
    [self.scrollView addSubview:self.cancelButton];
    
    if (YES) {
        [_textView setHidden:YES];
        _textView.editable = NO;
    } else {
        [_textField setHidden:YES];
        [_textField setEnabled:NO];
    }    
}

- (void)setConstraints {
    _toolViewBottomConstraintOffset = 0.f;
    WeakSelf(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
        make.height.width.equalTo(weakSelf.view);
    }];
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        _toolViewBottomConstraint = make.bottom.equalTo(weakSelf.view).offset(_toolViewBottomConstraintOffset);
        make.height.equalTo(@(kGRViewControllerToolViewHeight));
    }];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
        make.height.mas_equalTo(2000);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.bgView).offset(700);
        make.height.equalTo(@60);
        make.width.equalTo(@200);
    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.bgView).offset(700);
        make.height.equalTo(@60);
        make.width.equalTo(@200);
    }];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textView.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.textView);
        make.height.equalTo(@50);
        make.width.equalTo(@200);
    }];
}

#pragma mark - getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.contentInset = UIEdgeInsetsMake(70, 0, kGRViewControllerToolViewHeight, 0);
    }
    return _scrollView;
}

- (UIView *)toolView {
    if (!_toolView) {
        _toolView = [[UIView alloc] init];
        _toolView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    }
    return _toolView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = @"Test";
    }
    return _textField;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor greenColor];
    }
    return _textView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor blueColor];
    }
    return _bgView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

@end
