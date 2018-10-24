
//
//  CustomProgress.m
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "CustomProgress.h"

@interface CustomProgress()


@end


@implementation CustomProgress

#pragma mark 构造方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 默认最大值100
        self.maxValue = 100.f;
        
        self.backgroundColor = [UIColor clearColor];
        
        // 背景图片
        self.bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.bgimg.layer.cornerRadius = self.frame.size.height/2;
        [self.bgimg.layer setMasksToBounds:YES];
        
        [self addSubview:self.bgimg];
        
        // 进度条背景图片
        self.leftimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        self.leftimg.layer.cornerRadius = self.bgimg.layer.cornerRadius;
        [self.leftimg.layer setMasksToBounds:YES];
        [self addSubview:self.leftimg];
        
        // 进度条上要展示的文字
        self.presentlab = [[UILabel alloc] initWithFrame:self.bgimg.bounds];
        self.presentlab.textAlignment = NSTextAlignmentCenter;
        self.presentlab.textColor = [UIColor grayColor];
        self.presentlab.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.presentlab];
    }
    return self;
}


#pragma mark 设置进度条值
-(void)setProgress:(NSUInteger)progress
{
    // 防止被除数为0
    if((progress > 0) && (self.maxValue > 0)){
        
        [UIView animateWithDuration:0.2 animations:^{
            
            // 根据进度条的值 算出展示的长度
            self.leftimg.frame = CGRectMake(0, 0, self.frame.size.width/self.maxValue*progress, self.frame.size.height);
            self.presentlab.frame = self.leftimg.frame;
            // 显示进度数据
            self.presentlab.text = [NSString stringWithFormat:@"%lu％",(unsigned long)progress];

        } completion:^(BOOL finished) {
            
            
        }];
    }
    
}


#pragma mark 显示方法
- (void)show{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    
    // 界面出现动画及位置
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:0.25 animations:^{
        // 标准状态
        self.transform = CGAffineTransformIdentity;
        
    }];
    
    
}

// 隐藏方法
- (void)hide{
    
    // 界面消失动画
    [UIView animateWithDuration:0.2 animations:^{
        
        // 退下键盘
        self.alpha = 0.2;
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        self.leftimg.bounds = CGRectZero;
        self.presentlab.frame = CGRectZero;
        
    }];
}



@end
