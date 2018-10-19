//
//  MBSPrefixDefine.h
//  Game
//
//  Created by 陈创 on 2018/10/19.
//  Copyright © 2018年 陈创. All rights reserved.
//

#ifndef MBSPrefixDefine_h
#define MBSPrefixDefine_h

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kStatusBarHeight CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
#define MB_RGB(__r, __g, __b) [UIColor colorWithRed:(__r / 255.0) green:(__g / 255.0) blue:(__b / 255.0) alpha:1]
#define MB_RGBA(__r, __g, __b, __a) [UIColor colorWithRed:(__r / 255.0) green:(__g / 255.0) blue:(__b / 255.0) alpha:__a]


#define DeviceIsIphoneX (kScreenHeight > 811)
#define kIphoneXHomeHeight ((DeviceIsIphoneX)?(34.f):(0))
#define kToolBarHeight 44.0f

#endif /* MBSPrefixDefine_h */
