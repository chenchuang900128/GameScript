//
//  MBSSuspendControl.h
//  Game
//
//  Created by 陈创 on 2018/10/17.
//  Copyright © 2018年 陈创. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBSUpDownButton;
@class UIViewExt;


typedef void (^myClickBlock)(NSUInteger index);


@interface MBSSuspendControl : UIView

// 初始化方法
- (instancetype)initWithClickBlock:(myClickBlock)block;

// 显示
- (void)show;

// 隐藏
- (void)hide;

// 是否展开
@property(nonatomic,assign)BOOL isShow;

@end
