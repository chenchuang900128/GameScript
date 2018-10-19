//
//  NSString+Utils.m
//  BOCMBCI
//
//  Created by Tracy E on 13-4-12.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import "NSStringUtils.h"
#import "MBGlobalCore.h"

@implementation NSString (Utils)

+ (NSString *)stringWithString:(NSString *)string times:(NSInteger)times{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < times; i++) {
        [result appendString:string];
    }
    return result;
}

- (NSString *)replace:(NSString *)o with:(NSString *)n{
    return [self stringByReplacingOccurrencesOfString:o withString:n];
}

- (NSString *)format4n4{
    NSInteger len = self.length;
    if (len < 8) {
        return self;
    }
    NSRange range = NSMakeRange(4, len - 8);
    NSString *points = [NSString stringWithString:@"*" times:6];
    return [self stringByReplacingCharactersInRange:range withString:points];
}

//手机号码格式
- (NSString *)mobileFormat
{
    NSInteger len = self.length;
    if (len <= 7) {
        return self;
    }
    NSRange range = NSMakeRange(3, len - 7);
//    NSString *points = [NSString stringWithString:@"*" times:4];
    return [self stringByReplacingCharactersInRange:range withString:@"***"];
}

//隐藏的手机号显示格式  137 *** 6699
- (NSString *)formatForHideMobile
{
    return [self stringByReplacingOccurrencesOfString:@"***" withString:@" *** "];
}

//手机号 3-4-4 格式
-(NSString *)mobile344Format{
    NSInteger stringLength = self.length;
    NSMutableString *str =[NSMutableString stringWithString:self];
    if (stringLength >= 4 && stringLength < 8) {
        [str insertString:@" " atIndex:3];
    }else if (stringLength >=8 && stringLength <= 11) {
        [str insertString:@" " atIndex:3];
        [str insertString:@" " atIndex:8];
    }
    return [NSString stringWithFormat:@"%@",str];
}

//证件号码格式   4 3 4 格式
-(NSString *)credTextFormat{
    if (self == Nil) {
        return @"";
    }
    NSInteger len = self.length;
    if (len < 8) {
        return self;
    }
//    NSRange range = NSMakeRange(4,4);
//    NSString *points = [NSString stringWithString:@"*" times:4];
//    return [self stringByReplacingCharactersInRange:range withString:points];
    
    NSRange range1 = NSMakeRange(0, 4);
    NSRange range2 = NSMakeRange(len-4, 4);
    NSString *creText = [NSString stringWithFormat:@"%@***%@",[self substringWithRange:range1],[self substringWithRange:range2]];
    return creText;
}

- (NSString *)phoneNumberTrim{
    NSString *str =  [[[[[[self replace:@"-" with:@""] replace:@"+86" with:@""] replace:@"(" with:@""] replace:@")" with:@""] replace:@" " with:@""] replace:@"." with:@""];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    str = [str stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    return str;
}

- (NSString *)formatMonery{
    if (self.length == 0) {
        return @"";
    }
    //这里的修改是为了适应IOS 8 以前的－0.05处理 会是（0.05）
    BOOL  isChange = NO;
    if (![backVailString(self) isEqualToString:@""]&&[backVailString(self) floatValue]<0) {
        isChange = YES;
        
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[self replace:@"," with:@""]];
    if (isChange) {
        NSString * tempStr = [self replace:@"-" with:@""];
        NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[tempStr replace:@"," with:@""]];
        return [NSString stringWithFormat:@"-%@",[formatter stringFromNumber:number]];;
    }
    else
    {
        
       return [formatter stringFromNumber:number];
    }
    
}


- (NSString *)formatMonerySpecial{
    return [[self formatMonery] componentsSeparatedByString:@"."][0];
}

- (NSString *)formatMoneryThreeDecimal
{
    NSString * value = [NSString stringWithFormat:@"%.3f",
                        [[self replace:@"," with:@""] doubleValue]];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setCurrencySymbol:@""];
    
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[value componentsSeparatedByString:@"."][0]];
    return [NSString stringWithFormat:@"%@.%@",
            [formatter stringFromNumber:number],
            [value componentsSeparatedByString:@"."][1]];
}

-(NSString *)formatBalance{
    return [[[self formatMonery] replace:@"," with:@""] substringToIndex:[[self formatMonery] replace:@"," with:@""].length-1];
}

- (NSString *)correctUserInput
{
    NSString *result = self;
    if (result.length > 0)
    {
        if ([result hasPrefix:@"."])
        {
            result = [NSString stringWithFormat:@"0%@",result];
        }
    }
    return result;
}
-(NSString *)formatAnyDecimal{
    if ([[self componentsSeparatedByString:@"."] count]==1) {
        return [[self formatMonery] componentsSeparatedByString:@"."][0];
    }
    NSString *str=[self componentsSeparatedByString:@"."][1];
    NSString *value=[[self formatMonery] componentsSeparatedByString:@"."][0];
    if (!value) {
        return [NSString stringWithFormat:@"0.%@",str];
    }
    return [NSString stringWithFormat:@"%@.%@",value,str];
}



- (NSString *)formatWhiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)formatWhiteSpaceAndNewLineCharacterSet
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)format4Space{
    NSInteger spaceNum=self.length%4?self.length/4:self.length/4-1;
    NSMutableString *str =[NSMutableString stringWithString:self];
    for (int i =0 ; i<spaceNum; i++) {
        [str insertString:@" " atIndex:4*(i+1)+i];
    }
    return [NSString stringWithFormat:@"%@",str];
}

-(NSString *)formatHideFormat{
    if (self.length < 8) {
        return self;
    }
    NSInteger len = self.length;
    NSRange range1 = NSMakeRange(0, len-8);
    NSRange range2 = NSMakeRange(len-4, 4);
    NSString *creText = [NSString stringWithFormat:@"%@****%@",[self substringWithRange:range1],[self substringWithRange:range2]];
    return creText;
}
//时间格式化  "20130712133125"  to  "2013-07-12 13:31" or "20130712" to "2013-07-12"
-(NSString *)timeFormat{
    if (self.length == 14) {
        NSRange range = NSMakeRange(0, 12);
        NSMutableString *muString = [[NSMutableString alloc] initWithString:[self substringWithRange:range]];
        [muString insertString:@"-" atIndex:4];
        [muString insertString:@"-" atIndex:7];
        [muString insertString:@" " atIndex:10];
        [muString insertString:@":" atIndex:13];
        return (NSString *)muString;
    }
    if (self.length == 8) {
        NSRange range = NSMakeRange(0, 8);
        NSMutableString *muString = [[NSMutableString alloc] initWithString:[self substringWithRange:range]];
        [muString insertString:@"-" atIndex:4];
        [muString insertString:@"-" atIndex:7];
        return (NSString *)muString;
    }
    return self;
}
//删掉实践中的  ‘-’  如："2014-08-11"  to "20140811"
-(NSString *)timeHideFormat{
    return [[self replace:@"-" with:@""] replace:@" " with:@""];
}

//删掉空格号
-(NSString *)formatDeleteSpace{
    return [self replace:@" " with:@""];
}

#pragma mark 将数字转化成大写金额
- (NSString *)moneyStringWithDigitStr
{
    NSRange range=[self rangeOfString:@"."];
    
    NSString *digitString;
    
    if (range.location!=NSNotFound) {
        digitString=[self substringToIndex:range.location];
    }
    else{
        digitString=self;
    }
    
    NSArray *datas = [NSArray arrayWithObjects:@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖", nil];
    NSArray *infos = [NSArray arrayWithObjects:@"圆", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"万", nil];
    
    NSMutableString *processString = [[NSMutableString alloc] initWithString:digitString];
    
    if (!([processString rangeOfString:@"."].location==NSNotFound)) {
        [processString deleteCharactersInRange:[processString rangeOfString:[processString substringFromIndex:[processString rangeOfString:@"."].location]]];
    };
    
    NSMutableString *resultString = [NSMutableString string];
    int i = 0;
    int j = processString.length;
    
    // str:165047523
    // 1亿 6仟 5佰 0拾 4万 7仟 5佰 2拾 3分 ——> 壹亿 陆仟 伍佰 零拾 肆万 柒仟 伍佰 贰拾 叁分
    while (processString.length != 0) {
        [resultString insertString:[infos objectAtIndex:i] atIndex:0];
        i++;
        j--;
        NSString *specifiedNumberStrAtIndex = [processString substringWithRange:NSMakeRange(j, 1)];
        int specifiedNumber = [specifiedNumberStrAtIndex intValue];
        int number = specifiedNumber % 10;
        [resultString insertString:[datas objectAtIndex:number] atIndex:0];
//        if (number==0) {
//            if (resultString.length==2) {
//                [resultString deleteCharactersInRange:NSMakeRange(0, 1)];
//            }
//            else{
//            [resultString deleteCharactersInRange:NSMakeRange(2, 1)];
////            [resultString deleteCharactersInRange:NSMakeRange(0, 1)];
//            }
//        }
        [processString deleteCharactersInRange:NSMakeRange(j, 1)];
    }
    
    NSString *moneyString = [NSString stringWithFormat:@"%@",resultString];
    NSError *error=nil;
    NSArray *expressions = [NSArray arrayWithObjects:@"零[拾佰仟]", @"零+亿", @"零+万", @"零+元", @"零+",@"亿万",nil];
    NSArray *changes = [NSArray arrayWithObjects:@"零", @"亿",@"万",@"",@"零",@"亿",nil];
    
    for (int k = 0; k < 6; k++)
    {
        @autoreleasepool{
        NSRegularExpression *reg=[[NSRegularExpression alloc] initWithPattern:[expressions objectAtIndex:k] options:NSRegularExpressionCaseInsensitive error:&error];
        
        moneyString = [reg stringByReplacingMatchesInString:moneyString options:0 range:NSMakeRange(0, moneyString.length) withTemplate:[changes objectAtIndex:k]];
        }
    }
    NSString * diaoHou;
    if ([self rangeOfString:@"."].location!=NSNotFound) {
        diaoHou=[self format:[NSString stringWithFormat:@"%@",[self substringFromIndex:([self rangeOfString:@"."].location+1)]]];
    }
    else{
    diaoHou=@"";
    }
    
    NSString *zheng=diaoHou.length>0?@"":@"整";
    
    NSMutableString *reusltMoneyString=[[NSMutableString alloc] initWithString:moneyString];
    
    NSRange yuanRange= [reusltMoneyString rangeOfString:@"圆"];
    if ([[reusltMoneyString substringWithRange:NSMakeRange(yuanRange.location-1, 1)] isEqualToString:@"零"]) {
        [reusltMoneyString deleteCharactersInRange:NSMakeRange(yuanRange.location-1, 1)];
    }
    
    return [NSString stringWithFormat:@"%@%@%@",(reusltMoneyString.length>1)?reusltMoneyString:@"",diaoHou,zheng];
    
}
-(NSString *)format:(NSString *)comeStr{
    NSArray *datas = [NSArray arrayWithObjects:@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖", nil];
    NSMutableString *mulStr=[[NSMutableString alloc] initWithCapacity:2];
    
    if (comeStr.length==1) {
        int number=comeStr.intValue % 10;
        if (number!=0) {
            [mulStr insertString:[datas objectAtIndex:number] atIndex:mulStr.length];
            [mulStr insertString:@"角" atIndex:mulStr.length];
        }
    }
    else if (comeStr.length>1){
        int numberOne=[comeStr substringToIndex:1].intValue;
        if (numberOne!=0) {
            [mulStr insertString:[datas objectAtIndex:numberOne] atIndex:mulStr.length];
            [mulStr insertString:@"角" atIndex:mulStr.length];
        }

        int numberTwo=[comeStr substringWithRange:NSMakeRange(1, 1)].intValue;
        if (numberTwo!=0) {
            [mulStr insertString:[datas objectAtIndex:numberTwo] atIndex:mulStr.length];
            [mulStr insertString:@"分" atIndex:mulStr.length];
        }
    }
    return mulStr;
}



//将元转换为分 如：1 转为 100
-(NSString*)getCentStr
{
    float  cent  = [self doubleValue];
    return [NSString stringWithFormat:@"%f",cent*100];
  
}
#pragma mark 显示前面三位+星号
-(NSString*)loginNameFormat
{
    if (self.length < 3) {
        return self;
    }

    NSString * backStr = [self substringToIndex:3];
    backStr = [NSString stringWithFormat:@"%@***",backStr];
    return backStr;
}
#pragma mark 邮箱格式
-(NSString*)emailFormat
{
    

    NSArray * tempArr = [self componentsSeparatedByString:@"@"];
    if ([tempArr count]>0) {
        if (((NSString*)[tempArr firstObject]).length<=3) {
            return self;
        }
        else
        {
            
            NSString * str = [tempArr firstObject];
            str = [NSString stringWithFormat:@"%@***@%@",[str substringToIndex:3],[tempArr lastObject]];
            return str;
            
        }
        
    }
    
   
    
    return @"格式错误";
    
}

//交通处罚书第六位添加 "-"
-(NSString *)insertString{
    NSMutableString *tempString = [[NSMutableString alloc] initWithString:self];
    if (tempString.length > 7) {
        [tempString insertString:@"-" atIndex:6];
    }
    return tempString;
}

//用户名，前面用*号代替 ，剩下最后一个字  例如：*杰伦
-(NSString *)showPartName{
    NSString *lastS= [self substringFromIndex:1];
    NSString *allS=[NSString stringWithFormat:@"*%@",lastS];
    return allS;
}




@end
