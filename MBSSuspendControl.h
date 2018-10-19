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

- (instancetype)initWithClickBlock:(myClickBlock)block;

- (void)show;

- (void)hide;

@property(nonatomic,assign)BOOL isShow;

@end
