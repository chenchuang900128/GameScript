//
//  MBSTextField.h
//  MBSiPhone
//
//  Created by llbt on 13-12-10.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 键盘类型keyboardType：
 *  手机号：UIKeyboardTypeNumberPad
 *  金额输入框：UIKeyboardTypeDecimalPad
 *  邮件输入框：UIKeyboardTypeEmailAddress
 */

typedef enum {
    MBSDefault_type,  //默认
    MBSMoney_type,  //金额
    MBSAccountNum,                     //四位一空格
    MBSPassword,     //密码
    MBSMoney_FanXian,
    MBSPhoneNum      //手机号3-4-4格式 如：186 8888 8888
}textFieldType;  //输入框类型

typedef void (^textFieldFormattBack_block)(NSString *);  //输入框金额格式化返回

@interface MBSTextField : UITextField
@property (nonatomic, assign) NSUInteger textMaxLength;

//不用设置
@property (nonatomic, assign) NSUInteger realTextMaxLength;
//是否可以复制，默认可以复制
@property (nonatomic, assign) BOOL copyEnabled;             //Default is YES.
@property (unsafe_unretained, nonatomic) id<UITextFieldDelegate> textFieldDelegate;

@property(nonatomic,unsafe_unretained) textFieldType selfType; //输入框类型
@property(nonatomic,copy) textFieldFormattBack_block textFieldFormattBack;  //输入框返回格式化
// 强制修改字体大小
- (void)forceChangeTextFont:(UIFont *)font;
// 默认金额输入框
+ (instancetype)defaultMoneyFieldFrame:(CGRect)frame;
// 默认输入框
+ (instancetype)defaultFieldFrame:(CGRect)frame;
@end

@protocol MBSTextFieldDelegate <NSObject, UITextFieldDelegate>
@optional
- (void)textFieldDidCancelEditing:(MBSTextField *)textField; //点击键盘上的“取消”按钮。
- (void)textFieldDidFinsihEditing:(MBSTextField *)textField; //点击键盘框上的"确认"按钮。

@end

