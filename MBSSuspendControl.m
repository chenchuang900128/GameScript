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


// 展开视图
@property (nonatomic,strong)UIView *otherView;
// 点击Block
@property (nonatomic,copy)myClickBlock clickBlock;
// 是否展开
@property(nonatomic,assign)BOOL isShow;

// 悬浮窗是否在右边
@property(nonatomic,assign)BOOL isRight;

@end

@implementation MBSSuspendControl{
    
    UIButton *mainBtn;
}

- (instancetype)initWithClickBlock:(myClickBlock)block{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.clickBlock = block;
        
        _isShow = NO;
        _isRight = YES;
        
        //  设置frame 及 圆角
        self.frame = CGRectMake(kScreenWidth - 40, 94, 48, 48);
        self.layer.cornerRadius = 25.f;
        self.layer.masksToBounds = YES;
        
        // 设置背景颜色
        self.backgroundColor = MB_RGB(25, 21, 18);
        
        // 主菜单
        mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainBtn setImage:[UIImage imageNamed:@"GameScript.bundle/menu7"] forState:UIControlStateNormal];
        [mainBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        mainBtn.frame = CGRectMake(4, 4, 40, 40);
        mainBtn.layer.cornerRadius = 20.f;
        mainBtn.backgroundColor = MB_RGB(59, 45, 36);
        [self addSubview:mainBtn];
        
        
        // 添加平滑手势
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
        [mainBtn addGestureRecognizer:panGestureRecognizer];
        
        
        
        // 添加弹出菜单父视图
        self.otherView = [[UIView alloc] initWithFrame:CGRectMake(mainBtn.right + 10, 0, 34.5 * 5, 48)];
        self.otherView.hidden = YES;
        [self addSubview:self.otherView];
        
        // 循环创建子菜单
        NSArray *imgArr = @[@"GameScript.bundle/menu",@"GameScript.bundle/menu2",@"GameScript.bundle/menu3",@"GameScript.bundle/menu4",@"GameScript.bundle/menu5"];
        NSArray *titleArr = @[@"刷新",@"账号",@"客服",@"公告",@"礼包"];
        
        
        // 添加子菜单
        MBSUpDownButton *menuBtn;
        for (NSInteger i = 0; i < 5; i++) {
            
            menuBtn = [[MBSUpDownButton alloc] initWithFrame:CGRectMake(34.5 * i, 2, 34, 40) imgStr:imgArr[i] title:titleArr[i] imgSize:CGSizeMake(22, 22) spaceYCenter:4];
            [menuBtn setTitleColor:MB_RGB(212, 43, 43) forState:UIControlStateNormal];
            [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            menuBtn.tag = 10 + i;
            [self.otherView addSubview:menuBtn];
        }
        
    }
    
    return self;
}


#pragma mark   手势滑动触发事件

- (void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    // 移动状态
    UIGestureRecognizerState state =  panGestureRecognizer.state;
    
    switch (state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 改变状态 相对window移动了多少
            CGPoint transPoint = [panGestureRecognizer translationInView:[UIApplication sharedApplication].delegate.window];
            // 相应改变中心点
            self.center = CGPointMake(self.center.x + transPoint.x, self.center.y+transPoint.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
            //  手势结束后，确定的中心点
            CGPoint centerPoint = CGPointZero;
            
            if (self.center.y < kStatusBarHeight + 35) {

                // 在左边
                if(self.center.x < kScreenWidth/2){

                    self.isRight = NO;
                    centerPoint = CGPointMake(15, kStatusBarHeight + 35);

                }
                else{
                    self.isRight = YES;
                    centerPoint = CGPointMake(kScreenWidth-15, kStatusBarHeight + 35);

                }
            }
            else if(self.center.y > kScreenHeight - 50){

                if(self.center.x < kScreenWidth/2){

                    self.isRight = NO;
                    centerPoint = CGPointMake(15, kScreenHeight - 50);

                }
                else{
                    self.isRight = YES;
                    centerPoint = CGPointMake(kScreenWidth-15, kScreenHeight - 50);

                }

            }
            else{

                if(self.center.x < kScreenWidth/2){

                    self.isRight = NO;
                    centerPoint = CGPointMake(15, self.center.y);
                }
                else{
                    self.isRight = YES;
                    centerPoint = CGPointMake(kScreenWidth-15, self.center.y);
                }

            }

            self.isShow = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.otherView.hidden = YES;
                self.width = 48.f;
                self.center = centerPoint;

            } completion:^(BOOL finished) {

            }];
            
        }
            break;
            
        default:
            break;
    }
    [panGestureRecognizer setTranslation:CGPointMake(0, 0) inView:self];

}


#pragma mark  弹出菜单 刷新，公告，账号，客服等点击事件
- (void)menuBtnClick:(MBSUpDownButton *)sender{
    
    if (self.clickBlock) {
        self.clickBlock(sender.tag - 10);
    }
    
    self.isShow = NO;
    // 收缩
    [UIView animateWithDuration:0.2 animations:^{
        
        if (self.isRight) {
            self.left = kScreenWidth - 40.f;
            self.width = 48.f;
            self.otherView.hidden = YES;
        }
        else{
            self.left = -10.f;
            self.width = 48.f;
            self.otherView.hidden = YES;
        }
        
        
    } completion:^(BOOL finished) {
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            if (self.isRight) {
//                self.left = kScreenWidth - 34.f;
//            }
//            else{
//                self.left = -16.f;
//            }
//        });
    }];
}


#pragma mark  主菜单点击， 展开或收缩
- (void)btnClick:(MBSSuspendControl *)sender{
    
    _isShow = !_isShow;
    if (_isShow) {
        
        // 展开
        [UIView animateWithDuration:0.2 animations:^{
            
            if (self.isRight) {
                self.left = kScreenWidth - 240.f;
                self.width = 236.f;
            }
            else{
                self.left = 4;
                self.width = 236.f;
            }
            
            
        } completion:^(BOOL finished) {
            
            self.otherView.hidden = NO;
        }];
    }
    else{
        
        // 收缩
        [UIView animateWithDuration:0.2 animations:^{
            
            if (self.isRight) {
                self.left = kScreenWidth - 40.f;
                self.width = 48.f;
                self.otherView.hidden = YES;
            }
            else{
                self.left = -10.f;
                self.width = 48.f;
                self.otherView.hidden = YES;
            }
            
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
    }
    
    
}


#pragma mark  显示
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

#pragma mark  隐藏
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
