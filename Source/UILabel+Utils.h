//
//  UILabel+Utils.h
//  MBSiPhone
//
//  Created by tianliang on 14-2-14.
//  Copyright (c) 2014年 China M-World Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)

/**
 *  CNY和.00 变小   一定要在setText之后使用！！！！
 *
 *  @param bigFont 数字字体（大的）
 */





+(UILabel *)labelWithFrame:(CGRect)frame font:(UIFont *)myFont textColor:(UIColor *)textColor text:(NSString *)text;

@end
