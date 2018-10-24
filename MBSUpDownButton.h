//
//  GDDiyButton.h
//  ClickWeb
//
//  Created by 陈创 on 15/8/10.
//  Copyright (c) 2015年 Guandian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBSUpDownButton : UIButton

#pragma mark 图片在上，文字在下自定以按钮
-(instancetype)initWithFrame:(CGRect)frame imgStr:(NSString *)imgStr title:(NSString *)title imgSize:(CGSize)imgSize spaceYCenter:(CGFloat)spaceYCenter;


@end
