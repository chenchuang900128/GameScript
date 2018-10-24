//
//  MBSInputView.m
//  DrivingRecorder
//
//  Created by 陈创 on 2018/6/25.
//  Copyright © 2018年 chc. All rights reserved.
//

#import "MBSInputView.h"
#import "UILabel+Utils.h"
#import "UIViewExt.h"

@implementation MBSInputView


#pragma mark 有图片输入框构造方法
-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageStr{
    
    self = [super initWithFrame:frame];
    if(self){
        // 背景颜色
        self.backgroundColor = [UIColor clearColor];
        
        // 图标尺寸
        CGFloat imgSize = 24.f;

        // 图片
        UIImageView *headIV;
        headIV = [[UIImageView alloc] initWithFrame:CGRectMake(6, (frame.size.height-imgSize)/2, imgSize, imgSize)];
        headIV.image = [UIImage imageNamed:(imageStr)];
        [self addSubview:headIV];
        
        // 输入框
        _inputTF =  [[MBSTextField alloc] initWithFrame:CGRectMake(headIV.right + 10, 0, frame.size.width - headIV.right - 10, frame.size.height)];
        if ([UIScreen mainScreen].bounds.size.width < 321) {
            
            [_inputTF forceChangeTextFont:[UIFont systemFontOfSize:15]];
        }
        [self addSubview:_inputTF];
    }
    return self;
}


#pragma mark 设置输入框字体大小
-(void)setFieldFont:(UIFont *)fieldFont{
    [_inputTF forceChangeTextFont:fieldFont];
}

@end
