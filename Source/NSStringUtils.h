//
//  NSString+Utils.h
//  BOCMBCI
//
//  Created by Tracy E on 13-4-12.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

//字符串替换（如：[@"2013-05-01" replace:@"-" with@"/"];）
- (NSString *)replace:(NSString *)oldString with:(NSString *)newString;

//过滤手机号中一些特殊字符
- (NSString *)phoneNumberTrim;

//账户反显格式化(目前为4-6-4)
- (NSString *)format4n4;

//金额格式化 (99,888,000.00)
- (NSString *)formatMonery;

//特殊币种格式化不要小数点 (99,888,000)
- (NSString *)formatMonerySpecial;

//金额币种格式化带小数点后3位
- (NSString *)formatMoneryThreeDecimal;

//金额小数位不做控制
-(NSString *)formatAnyDecimal;

//更正用户输入
//例如：用户在金额输入.11实际是正常的，应该做一下更正
- (NSString *)correctUserInput;

//手机号格式化
- (NSString *)mobileFormat;
//隐藏的手机号显示格式  137 *** 6699
- (NSString *)formatForHideMobile;
//手机号 3-4-4 格式
-(NSString *)mobile344Format;

-(NSString *)credTextFormat;

//去除字符串前后空格
- (NSString *)formatWhiteSpace;

//去除字符串前后空格以及后面的换行
- (NSString *)formatWhiteSpaceAndNewLineCharacterSet;


//返回小数点后一位（不带逗号）
-(NSString *)formatBalance;

//银行账户4位一空格
-(NSString *)format4Space;
-(NSString *)formatHideFormat;

//时间格式化  "20130712133125"  to  "2013-07-12 13:31" or "20130712" to "2013-07-12"
-(NSString *)timeFormat;

//删掉实践中的  ‘-’  如："2014-08-11"  to "20140811"
-(NSString *)timeHideFormat;

//删掉空格号
-(NSString *)formatDeleteSpace;

//金额格式化,,,,大写话
- (NSString *)moneyStringWithDigitStr;


//将元转换为分 如：1 转为 100 
-(NSString*)getCentStr;
//登录名 显示前面三位+星号，eg：gouyongchao显示为gou***；
-(NSString*)loginNameFormat;
//邮箱 显示3位+星号+@+邮箱域名，eg：zldang@gdnybank.com显示为zld***@gdnybank.com，87435389@qq.com显示为874***@qq.com
-(NSString*)emailFormat;

//交通处罚书第六位添加 "-"
-(NSString *)insertString;
//用户名，前面用*号代替 ，剩下最后一个字  例如：****伦
-(NSString *)showPartName;

@end
