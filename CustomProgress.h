//
//  CustomProgress.h
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomProgress : UIView

// 背景图片
@property(nonatomic, strong)UIImageView *bgimg;
// 左边进度条图片
@property(nonatomic, strong)UIImageView *leftimg;
// 进度条上要展示的文字
@property(nonatomic, strong)UILabel *presentlab;

// 进度条最大值
@property(nonatomic,assign)float maxValue;

//设置进度条值
-(void)setProgress:(NSUInteger)progress;

// 显示
- (void)show;
// 隐藏
- (void)hide;
@end
