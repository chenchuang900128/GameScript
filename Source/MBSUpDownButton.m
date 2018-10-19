//
//  GDDiyButton.m
//  ClickWeb
//
//  Created by 陈创 on 15/8/10.
//  Copyright (c) 2015年 Guandian. All rights reserved.
//

#import "MBSUpDownButton.h"
#import "UIViewExt.h"

@implementation MBSUpDownButton{
    CGSize imgSize;
    // 距离中心点y轴距离
    CGFloat spaceYCenter;
}

#pragma mark 视图布局
-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置图片的位置 Center image
    CGPoint center;
    center.x = self.width/2;
    center.y = self.height/2 - 8;
    self.imageView.bounds = CGRectMake(0, 0, imgSize.width, imgSize.height);
    self.imageView.center = center;
    
    
    // 设置文字的位置  Center text
    CGPoint center2;
    center2.x = self.width/2;
    center2.y = (self.height)/2 + 10 + spaceYCenter;
    self.titleLabel.bounds = CGRectMake(0, 0, self.width, 20);
    self.titleLabel.center = center2;
    
    self.titleLabel.textAlignment  = NSTextAlignmentCenter;
    if (_textFont) {
        self.titleLabel.font = _textFont;
    }
    else{
        self.titleLabel.font = [UIFont systemFontOfSize:15];

    }
}


-(instancetype)initWithFrame:(CGRect)frame imgStr:(NSString *)imgStr title:(NSString *)title imgSize:(CGSize)size spaceYCenter:(CGFloat)spaceY
{
    self = [MBSUpDownButton buttonWithType:UIButtonTypeCustom];
    
    if (self) {
        
        imgSize = size;
        spaceYCenter = spaceY;
        [self setFrame:frame];
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
   

    }
    return self;
}


@end
