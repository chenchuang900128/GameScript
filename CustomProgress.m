
//
//  CustomProgress.m
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "CustomProgress.h"

@implementation CustomProgress


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 默认最大值100
        self.maxValue = 100.f;
        
        self.backgroundColor = [UIColor clearColor];
        self.bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.bgimg.layer.cornerRadius = self.frame.size.height/2;
        [self.bgimg.layer setMasksToBounds:YES];

        [self addSubview:self.bgimg];
        
        self.leftimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        self.leftimg.layer.cornerRadius = self.bgimg.layer.cornerRadius;
        [self.leftimg.layer setMasksToBounds:YES];
        [self addSubview:self.leftimg];
        
        self.presentlab = [[UILabel alloc] initWithFrame:self.bgimg.bounds];
        self.presentlab.textAlignment = NSTextAlignmentCenter;
        self.presentlab.textColor = [UIColor grayColor];
        self.presentlab.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.presentlab];
    }
    return self;
}


-(void)setProgress:(NSUInteger)progress
{
    self.leftimg.frame = CGRectMake(0, 0, self.frame.size.width/self.maxValue*progress, self.frame.size.height);
    
    self.presentlab.text = [NSString stringWithFormat:@"%lu％",progress];
    self.presentlab.frame = self.leftimg.frame;
}


- (void)show{
    
    //    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [window addSubview:self];
    
    // 界面出现动画及位置
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:0.25 animations:^{
        // 标准状态
        self.transform = CGAffineTransformIdentity;
        
    }];
    
    
}

- (void)hide{
    
    // 界面消失动画
    [UIView animateWithDuration:0.2 animations:^{
        
        // self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        // 退下键盘
        self.alpha = 0.2;
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        
    }];
}



@end
