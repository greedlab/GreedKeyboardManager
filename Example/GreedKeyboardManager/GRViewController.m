//
//  GRViewController.m
//  GreedKeyboardManager
//
//  Created by Bell on 04/05/2016.
//  Copyright (c) 2016 greedlab. All rights reserved.
//

#import "GRViewController.h"
#import "UIScrollView+GRKeyboardManager.h"
#import <Masonry/Masonry.h>

@interface GRViewController ()

@property (nonatomic, strong) GRKeyboardManager *manager;

@end

@implementation GRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initView];
    [self setConstraints];
    [_scrollView gr_keyboardManager];
    self.manager = [[GRKeyboardManager alloc] initWithScrollView:_scrollView];
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

#pragma mark - private

- (void)initView {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bgView];
    [self.scrollView addSubview:self.textView];
    [self.scrollView addSubview:self.cancelButton];
}

- (void)setConstraints {
    WeakSelf(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
        make.height.width.equalTo(weakSelf.view);
    }];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
        make.height.mas_equalTo(2000);
    }];
    //    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.equalTo(weakSelf.bgView);
    //        make.height.equalTo(@600);
    //        make.width.equalTo(@200);
    //    }];
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
    }
    return _scrollView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor greenColor];
        _textField.placeholder = @"Test";
    }
    return _textField;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textField.backgroundColor = [UIColor greenColor];
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
