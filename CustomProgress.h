//
//  CustomProgress.h
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomProgress : UIView

@property(nonatomic, strong)UIImageView *bgimg;
@property(nonatomic, strong)UIImageView *leftimg;
@property(nonatomic, strong)UILabel *presentlab;

@property(nonatomic,assign)float maxValue;

-(void)setProgress:(NSUInteger)progress;

- (void)show;
- (void)hide;
@end
