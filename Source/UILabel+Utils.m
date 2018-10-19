//
//  UILabel+Utils.m
//  MBSiPhone
//
//  Created by tianliang on 14-2-14.
//  Copyright (c) 2014年 China M-World Co.,Ltd. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)




+(UILabel *)labelWithFrame:(CGRect)frame font:(UIFont *)myFont textColor:(UIColor *)textColor text:(NSString *)text
{
    UILabel * modelLB = [[UILabel alloc] initWithFrame:frame];
    modelLB.numberOfLines = 0;
    modelLB.font = myFont;
    modelLB.textColor = textColor;
    if(text)
    {
        modelLB.text = text;
    }
    return modelLB;
}
@end
