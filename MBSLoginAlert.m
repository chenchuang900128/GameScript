//
//  MBSLoginAlert.m
//  Game
//
//  Created by 陈创 on 2018/10/17.
//  Copyright © 2018年 陈创. All rights reserved.
//

#import "MBSLoginAlert.h"
#import "MBSInputView.h"
#import "UIViewExt.h"
#import "UILabel+Utils.h"
#import "MBSPrefixDefine.h"





@interface MBSLoginAlert()

@property(nonatomic,strong)MBSInputView *loginNameV;
@property(nonatomic,strong)MBSInputView *pwdV;

@property(nonatomic,copy)CustomBlock logBlock;
@property(nonatomic,copy)CustomBlock regBlock;




@property (nonatomic,strong) UIView *cover;

@end


@implementation MBSLoginAlert



-(instancetype)initWithTitle:(NSString *)title loginBlock:(CustomBlock)loginBlock andRegisterBlock:(CustomBlock)registBlock{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.logBlock = loginBlock;
        self.regBlock = registBlock;
        
        CGFloat kSideX = 21.f;
        CGFloat fieldWidth = kScreenWidth - 2 * kSideX;
        CGFloat fieldHeight = 50;

        self.width = fieldWidth;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 0.f;
        self.layer.masksToBounds = YES;
        
        
        
        
        // 标题
        UILabel *titleLB = [UILabel  labelWithFrame:CGRectMake(0, 0,  self.width, 45) font:[UIFont systemFontOfSize:15] textColor:MB_RGB(227, 202, 125) text:title];
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.backgroundColor = [UIColor blackColor];
        [self addSubview:titleLB];
        
        
        self.loginNameV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, titleLB.bottom + 20, fieldWidth - 10, fieldHeight) imageName:@"GameScript.bundle/userName"];
        self.loginNameV.inputTF.placeholder = @"手机号";
        self.loginNameV.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.loginNameV];
        
        [self addLineOnBottem:self.loginNameV.frame];
        
        self.pwdV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, self.loginNameV.bottom, fieldWidth - 10, fieldHeight) imageName:@"GameScript.bundle/password"];
        self.pwdV.inputTF.placeholder = @"密码";
        self.pwdV.inputTF.secureTextEntry = YES;
        [self addSubview:self.pwdV];
        
        
        [self addLineOnBottem:self.pwdV.frame];
        
        
        // 227 202 125
        UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        regBtn.frame = CGRectMake(fieldWidth - 80, self.pwdV.bottom + 12, 65, 32);
        regBtn.layer.masksToBounds = YES;
        regBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [regBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [regBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [self addSubview:regBtn];
        

        // 227 202 125
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(20, regBtn.bottom + 13, fieldWidth - 40, 44);
        sureBtn.backgroundColor = MB_RGB(227, 202, 125);
        sureBtn.layer.cornerRadius = 22.f;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:sureBtn];
        
        regBtn.tag = 10;
        sureBtn.tag = 11;
        
        [regBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

        
    
        self.height = sureBtn.bottom + 13;
    }
    return self;
}



-(instancetype)initWithRegisterTitle:(NSString *)title loginBlock:(CustomBlock)loginBlock andRegisterBlock:(CustomBlock)registBlock{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.logBlock = loginBlock;
        self.regBlock = registBlock;
        
        CGFloat kSideX = 21.f;
        CGFloat fieldWidth = kScreenWidth - 2 * kSideX;
        CGFloat fieldHeight = 50;
        
        self.width = fieldWidth;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 0.f;
        self.layer.masksToBounds = YES;
        
        
        
        // 标题
        UILabel *titleLB = [UILabel  labelWithFrame:CGRectMake(0, 0,  self.width, 45) font:[UIFont systemFontOfSize:15] textColor:MB_RGB(227, 202, 125) text:title];
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.backgroundColor = [UIColor blackColor];
        [self addSubview:titleLB];
        
        
        self.loginNameV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, titleLB.bottom + 20, fieldWidth - 10, fieldHeight) imageName:@"GameScript.bundle/userName"];
        self.loginNameV.inputTF.placeholder = @"手机号";
        self.loginNameV.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.loginNameV];
        
        [self addLineOnBottem:self.loginNameV.frame];
        
        self.pwdV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, self.loginNameV.bottom, fieldWidth - 10, fieldHeight) imageName:@"GameScript.bundle/password"];
        self.pwdV.inputTF.placeholder = @"密码";
        self.pwdV.inputTF.secureTextEntry = YES;
        [self addSubview:self.pwdV];
        
        
        [self addLineOnBottem:self.pwdV.frame];
        
        
        MBSInputView *againPwdV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, self.pwdV.bottom, fieldWidth - 10, fieldHeight) imageName:@"GameScript.bundle/password"];
        againPwdV.inputTF.placeholder = @"密码";
        againPwdV.inputTF.secureTextEntry = YES;
        [self addSubview:againPwdV];
        
        
        [self addLineOnBottem:againPwdV.frame];
        
        
        // 227 202 125
        UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        regBtn.frame = CGRectMake(fieldWidth - 80, againPwdV.bottom + 13, 65, 32);
        regBtn.layer.masksToBounds = YES;
        regBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [regBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [regBtn setTitle:@"老用户登录" forState:UIControlStateNormal];
        [self addSubview:regBtn];
        
        
        // 227 202 125
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(20, regBtn.bottom + 13, fieldWidth - 40, 44);
        sureBtn.backgroundColor = MB_RGB(227, 202, 125);
        sureBtn.layer.cornerRadius = 22.f;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:sureBtn];
        
        regBtn.tag = 10;
        sureBtn.tag = 11;
        
        [regBtn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.height = sureBtn.bottom + 13;
    }
    return self;
}


- (void)btnClick:(UIButton *)sender{
    
    if (sender.tag == 10) {
        
        if(self.regBlock){
            self.regBlock(sender);
        }
        
    }
    else{
        
        if (self.logBlock) {
            self.logBlock(sender);
        }
    }
    
}

- (void)btnClick2:(UIButton *)sender{
    
    if (sender.tag == 10) {
        
        if (self.logBlock) {
            self.logBlock(sender);
        }
    }
    else{
        
        if(self.regBlock){
            self.regBlock(sender);
        }
    }
    
}

- (UIView *)cover{
    
    if (_cover == nil) {
        _cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        CGFloat rgb = 83 / 255.0;
        _cover.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.7];
    }
    return _cover;
}

- (void)show{
    
    //    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [window addSubview:self.cover];
    [window addSubview:self];
    
    // 设置微信支付界面出现动画及位置
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:0.25 animations:^{
        // 标准状态
        self.transform = CGAffineTransformIdentity;
        
    }];
    self.center = CGPointMake(window.center.x, (window.frame.size.height -  216)/2);
    if (DeviceIsIphoneX) {
        
    }
    
}

- (void)hide{
    
    // 设置微信支付界面消失动画
    [UIView animateWithDuration:0.2 animations:^{
        
        // self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        // 退下键盘
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.cover removeFromSuperview];
        
        
    }];
}

@end
