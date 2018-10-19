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

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


@implementation MBSInputView{
    UILabel *headLB;
}

-(instancetype)initWithFrame:(CGRect)frame offSetX:(CGFloat)offSetX{
    
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        headLB = [UILabel labelWithFrame:CGRectMake(0, 0, offSetX, frame.size.height) font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] text:@""];
        [self addSubview:headLB];
        
        _inputTF =  [[MBSTextField alloc] initWithFrame:CGRectMake(offSetX, 0, frame.size.width - offSetX, frame.size.height)];
        if (kScreenWidth < 321) {
            
            [_inputTF forceChangeTextFont:[UIFont systemFontOfSize:15]];

        }
        [self addSubview:_inputTF];
    }
    return self;
}


-(void)setHeadTitle:(NSString *)headTitle{
    headLB.text = headTitle;
}

-(void)setHeadFont:(UIFont *)headFont{
    headLB.font = headFont;
}

-(void)setFieldFont:(UIFont *)fieldFont{
    [_inputTF forceChangeTextFont:fieldFont];
}

-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageStr{
    
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *headIV;
        CGFloat imgSize = 24.f;
        headIV = [[UIImageView alloc] initWithFrame:CGRectMake(6, (frame.size.height-imgSize)/2, imgSize, imgSize)];
        headIV.image = [UIImage imageNamed:(imageStr)];
        [self addSubview:headIV];
        
        // 输入框
        _inputTF =  [[MBSTextField alloc] initWithFrame:CGRectMake(headIV.right + 10, 0, frame.size.width - headIV.right - 10, frame.size.height)];
        if (kScreenWidth < 321) {
            [_inputTF forceChangeTextFont:[UIFont systemFontOfSize:15]];

        }
        [self addSubview:_inputTF];
    }
    return self;
}

@end
