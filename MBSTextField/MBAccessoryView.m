//
//  MBInputAccessoryView.m
//  BOCMBCI
//
//  Created by Tracy E on 13-3-29.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import "MBAccessoryView.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kToolBarHeight 44.0f
#define MB_RGBA(__r, __g, __b, __a) [UIColor colorWithRed:(__r / 255.0) green:(__g / 255.0) blue:(__b / 255.0) alpha:__a]


@interface MBAccessoryView ()
{
    UILabel *_titleLabel;
}
@property (nonatomic, unsafe_unretained) id<MBAccessoryViewDelegate> accessoryDelegate;
@end

@implementation MBAccessoryView

- (void)dealloc
{
    _titleLabel = nil;
}

- (id)initWithDelegate:(id<MBAccessoryViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        // Initialization code
        self.accessoryDelegate = delegate;
        self.frame = CGRectMake(0, 0, kScreenWidth, kToolBarHeight);
        

        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(10, 0, 50, kToolBarHeight);
        cancelBtn.backgroundColor = [UIColor clearColor];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(inputCancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(kScreenWidth-60, 0, 50, kToolBarHeight);
        doneBtn.backgroundColor = [UIColor clearColor];
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(inputDone) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:doneBtn];
        
       
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
            self.backgroundColor =  MB_RGBA(0, 0, 0, 0.9);
        }
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (title) {
        [_titleLabel setText:title];
    }
}


- (void)inputCancel{
    if (_accessoryDelegate && [_accessoryDelegate respondsToSelector:@selector(accessoryViewDidPressedCancelButton:)]) {
        [_accessoryDelegate accessoryViewDidPressedCancelButton:self];
    }
}

- (void)inputDone{
    if (_accessoryDelegate && [_accessoryDelegate respondsToSelector:@selector(accessoryViewDidPressedDoneButton:)]) {
        [_accessoryDelegate accessoryViewDidPressedDoneButton:self];
    }
}


@end
