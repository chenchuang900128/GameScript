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

// 自定义输入框
@property(nonatomic,strong)MBSTextField *inputTF;

// 有图标输入框
-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageStr;

// 设置输入框字体大小
- (void)setFieldFont:(UIFont *)fieldFont;




@end
