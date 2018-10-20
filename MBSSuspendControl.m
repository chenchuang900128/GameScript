//
//  MBSSuspendControl.m
//  Game
//
//  Created by 陈创 on 2018/10/17.
//  Copyright © 2018年 陈创. All rights reserved.
//

#import "MBSSuspendControl.h"
#import "UIViewExt.h"
#import "MBSUpDownButton.h"
#import "MBSPrefixDefine.h"



@interface MBSSuspendControl()

@property (nonatomic,strong)UIView *otherView;
@property (nonatomic,copy)myClickBlock clickBlock;

@end

@implementation MBSSuspendControl{
}

- (instancetype)initWithClickBlock:(myClickBlock)block{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
     
        self.clickBlock = block;
        
        _isShow = NO;
        
        self.frame = CGRectMake(kScreenWidth - 60, 94, 50, 50);
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        self.layer.cornerRadius = 25.f;
        
        
        UIButton *mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [mainBtn setBackgroundImage:[UIImage imageNamed:@"GameScript.bundle/menu7"] forState:UIControlStateNormal];
        [mainBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        mainBtn.frame = CGRectMake(8, 8, 32, 32);
        
        [self addSubview:mainBtn];
        
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
        [mainBtn addGestureRecognizer:panGestureRecognizer];
        
        
        

        
        self.otherView = [[UIView alloc] initWithFrame:CGRectMake(mainBtn.right + 3, 0, 34 * 5, 50)];
        self.otherView.hidden = YES;
        [self addSubview:self.otherView];
        
        NSArray *imgArr = @[@"GameScript.bundle/menu",@"GameScript.bundle/menu2",@"GameScript.bundle/menu3",@"GameScript.bundle/menu4",@"GameScript.bundle/menu5"];
        NSArray *titleArr = @[@"刷新",@"账号",@"客服",@"公告",@"礼包"];

        MBSUpDownButton *menuBtn;
        for (NSInteger i = 0; i < 5; i++) {
            
            menuBtn = [[MBSUpDownButton alloc] initWithFrame:CGRectMake(34 * i,2, 34,40) imgStr:imgArr[i] title:titleArr[i] imgSize:CGSizeMake(22, 22) spaceYCenter:5];
            [menuBtn setTitleColor:MB_RGB(212, 43, 43) forState:UIControlStateNormal];
            [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            menuBtn.tag = 10 + i;
            [self.otherView addSubview:menuBtn];
        }
        
    }
    
    return self;
}


- (void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    
    CGPoint touchPoint = [panGestureRecognizer locationInView:[UIApplication sharedApplication].delegate.window];
    
    if (touchPoint.y < kStatusBarHeight + 35) {
        
        self.center = CGPointMake(self.center.x, kStatusBarHeight + 35);
    }
    else if(touchPoint.y > kScreenHeight - 50){
        
        self.center = CGPointMake(self.center.x, kScreenHeight - 50);
    }
    else{
        self.center = CGPointMake(self.center.x, touchPoint.y);

    }
    
    
}

- (void)menuBtnClick:(MBSUpDownButton *)sender{

    if (self.clickBlock) {
        
        self.clickBlock(sender.tag - 10);
    }
    
}


- (void)btnClick:(MBSSuspendControl *)sender{
    
    NSLog(@"悬浮窗");
    _isShow = !_isShow;
    if (_isShow) {
     
        [UIView animateWithDuration:0.2 animations:^{
            
            self.left = kScreenWidth - 230.f;
            self.width = 230.f;
        } completion:^(BOOL finished) {
            
            self.otherView.hidden = NO;
        }];
    }
    else{
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.left = kScreenWidth - 60.f;
            self.width = 50.f;
            self.otherView.hidden = YES;

        } completion:^(BOOL finished) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.left = kScreenWidth - 30;
                
            });
        }];
        
       
    }
    
   
}



- (void)show{
    
    //    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [window addSubview:self];
    
    // 设置微信支付界面出现动画及位置
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:0.25 animations:^{
        // 标准状态
        self.transform = CGAffineTransformIdentity;
        
    }];
   
    
}

- (void)hide{
    
    // 设置微信支付界面消失动画
    [UIView animateWithDuration:0.2 animations:^{
        
        // self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        // 退下键盘
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        
    }];
}




@end
