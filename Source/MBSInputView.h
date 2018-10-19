//
//  MBSInputView.h
//  DrivingRecorder
//
//  Created by 陈创 on 2018/6/25.
//  Copyright © 2018年 chc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSTextField.h"

@interface MBSInputView : UIControl

@property(nonatomic,strong)MBSTextField *inputTF;

// 有标题输入框
-(instancetype)initWithFrame:(CGRect)frame offSetX:(CGFloat)offSetX;
// 设置标题
- (void)setHeadTitle:(NSString *)headTitle;
// 设置标题
- (void)setHeadFont:(UIFont *)headFont;
// 设置标题
- (void)setFieldFont:(UIFont *)fieldFont;

// 有图标输入框
-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageStr;


@end
