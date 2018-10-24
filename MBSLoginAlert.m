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

// 输入控件
@property(nonatomic,strong)MBSInputView *loginNameV;
@property(nonatomic,strong)MBSInputView *pwdV;

// 登录，注册响应block
@property(nonatomic,copy)CustomBlock logBlock;
@property(nonatomic,copy)CustomBlock regBlock;

// 遮盖视图
@property (nonatomic,strong) UIView *cover;

@end


@implementation MBSLoginAlert


#pragma mark  登录弹框构造方法
-(instancetype)initWithTitle:(NSString *)title loginBlock:(CustomBlock)loginBlock andRegisterBlock:(CustomBlock)registBlock{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        // block 赋值
        self.logBlock = loginBlock;
        self.regBlock = registBlock;
        
        // 设置弹框在屏幕的位置及宽度
        CGFloat kSideX = 21.f;
        self.width = kScreenWidth - 2 * kSideX;

       
        // 设置圆角及背景
        self.layer.cornerRadius = 0.f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
       
        
        // 设置输入框高度
        CGFloat fieldHeight = 50;
        
        
        // 标题
        UILabel *titleLB = [UILabel  labelWithFrame:CGRectMake(0,  0,  self.width, 45) font:[UIFont systemFontOfSize:15] textColor:MB_RGB(227, 202, 125) text:title];
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.backgroundColor = [UIColor blackColor];
        [self addSubview:titleLB];
        
        
        // 手机号输入框
        self.loginNameV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, titleLB.bottom + 20, self.width - 10, fieldHeight) imageName:@"GameScript.bundle/userName"];
        self.loginNameV.inputTF.placeholder = @"手机号";
        self.loginNameV.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.loginNameV];
        
        [self addLineOnBottem:self.loginNameV.frame];
        
        // 密码输入框
        self.pwdV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, self.loginNameV.bottom, self.width - 10, fieldHeight) imageName:@"GameScript.bundle/password"];
        self.pwdV.inputTF.placeholder = @"密码";
        self.pwdV.inputTF.secureTextEntry = YES;
        [self addSubview:self.pwdV];
        
        // 添加华丽分割线
        [self addLineOnBottem:self.pwdV.frame];
        
        
        // 新用户注册
        UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        regBtn.frame = CGRectMake(self.width - 80, self.pwdV.bottom + 12, 65, 32);
        regBtn.layer.masksToBounds = YES;
        regBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [regBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [regBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        // 设置tag
        regBtn.tag = 10;
        [regBtn addTarget:self action:@selector(loginAlertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:regBtn];
        
        
        // 确定事件
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(20, regBtn.bottom + 13, self.width - 40, 44);
        sureBtn.backgroundColor = MB_RGB(227, 202, 125);
        sureBtn.layer.cornerRadius = 22.f;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.tag = 11;
        [sureBtn addTarget:self action:@selector(loginAlertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        
        
        // 设置登录弹框高度
        self.height = sureBtn.bottom + 13;
    }
    return self;
}


#pragma mark 登录弹框 登录 注册按钮响应事件
- (void)loginAlertBtnClick:(UIButton *)sender{
    
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








#pragma mark  注册弹框构造方法
-(instancetype)initWithRegisterTitle:(NSString *)title loginBlock:(CustomBlock)loginBlock andRegisterBlock:(CustomBlock)registBlock{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.logBlock = loginBlock;
        self.regBlock = registBlock;
        
        // 设置弹框在屏幕的位置及宽度
        CGFloat kSideX = 21.f;
        self.width = kScreenWidth - 2 * kSideX;

       
        
         // 设置圆角及背景
        self.layer.cornerRadius = 5.f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];

        
        
        // 标题
        UILabel *titleLB = [UILabel  labelWithFrame:CGRectMake(0, 0,  self.width, 45) font:[UIFont systemFontOfSize:15] textColor:MB_RGB(227, 202, 125) text:title];
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.backgroundColor = [UIColor blackColor];
        [self addSubview:titleLB];
        
        
        // 设置输入框高度
        CGFloat fieldHeight = 50;
        
        // 手机号输入框
        self.loginNameV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, titleLB.bottom + 20, self.width - 10, fieldHeight) imageName:@"GameScript.bundle/userName"];
        self.loginNameV.inputTF.placeholder = @"手机号";
        self.loginNameV.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.loginNameV];
        
        // 添加华丽分割线
        [self addLineOnBottem:self.loginNameV.frame];
        
        // 密码输入框
        self.pwdV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, self.loginNameV.bottom, self.width - 10, fieldHeight) imageName:@"GameScript.bundle/password"];
        self.pwdV.inputTF.placeholder = @"密码";
        self.pwdV.inputTF.secureTextEntry = YES;
        [self addSubview:self.pwdV];
        
        // 添加华丽分割线
        [self addLineOnBottem:self.pwdV.frame];
        
        // 确认密码输入框
        MBSInputView *againPwdV = [[MBSInputView alloc] initWithFrame:CGRectMake(5, self.pwdV.bottom, self.width - 10, fieldHeight) imageName:@"GameScript.bundle/password"];
        againPwdV.inputTF.placeholder = @"确认密码";
        againPwdV.inputTF.secureTextEntry = YES;
        [self addSubview:againPwdV];
        
        
        [self addLineOnBottem:againPwdV.frame];
        
        
        // 老用户登录
        UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        regBtn.frame = CGRectMake(self.width - 80, againPwdV.bottom + 13, 65, 32);
        regBtn.layer.masksToBounds = YES;
        regBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [regBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [regBtn setTitle:@"老用户登录" forState:UIControlStateNormal];
        regBtn.tag = 10;
        [regBtn addTarget:self action:@selector(registerAlertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:regBtn];
        
        
        // 确定
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(20, regBtn.bottom + 13, self.width - 40, 44);
        sureBtn.backgroundColor = MB_RGB(227, 202, 125);
        sureBtn.layer.cornerRadius = 22.f;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.tag = 11;
        [sureBtn addTarget:self action:@selector(registerAlertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        
        
        // 设置注册弹框高度
        self.height = sureBtn.bottom + 13;
    }
    return self;
}




#pragma mark 注册弹框 登录 注册响应事件
- (void)registerAlertBtnClick:(UIButton *)sender{
    
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

#pragma mark 遮挡面纱视图
- (UIView *)cover{
    
    if (_cover == nil) {
        
        CGFloat rgb = 83 / 255.0;
        _cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _cover.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.7];
    }
    return _cover;
}


#pragma mark 显示视图
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
    
}

#pragma mark 隐藏视图
- (void)hide{
    
    // 界面消失动画
    [UIView animateWithDuration:0.2 animations:^{
        
        // self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.cover removeFromSuperview];
        
        
    }];
}

@end
