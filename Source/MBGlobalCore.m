//
//  ESClobalCore.m
//  DandelionPhone
//
//  Created by Tracy E on 12-11-30.
//  Copyright (c) 2012 China M-World Co.,Ltd. All rights reserved.
//

#import "MBGlobalCore.h"

#import <objc/runtime.h>

// No-ops for non-retaining objects.
static const void* MBRetainNoOp(CFAllocatorRef allocator, const void *value) { return value; }
static void MBReleaseNoOp(CFAllocatorRef allocator, const void *value) { }





///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL MBIsArrayWithItems(id object) {
    return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL MBIsSetWithItems(id object) {
    return [object isKindOfClass:[NSSet class]] && [(NSSet*)object count] > 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL MBIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void SwapMethods(Class cls, SEL originalSel, SEL newSel) {
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    method_exchangeImplementations(originalMethod, newMethod);
}

NSString* MBNonEmptyString(id obj){
    if (obj == nil || obj == [NSNull null] ||
        ([obj isKindOfClass:[NSString class]] && [obj length] == 0)) {
        return @"--";
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return MBNonEmptyString([obj stringValue]);
    }
    return obj;
}

#pragma mark 返回合法字符串
id backVailString(id obj)
{
    NSString * backStr = @"";
    if (obj==nil||([obj isKindOfClass:[NSNull class]])||!obj) {
       
        
        return backStr;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        backStr = [obj stringValue];
        return backStr;
       
    }
    
    return obj;


}

NSString* MBNonEmptyStringNo_(id obj){
    return [MBNonEmptyString(obj) stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

BOOL MBIsStringContantDrop(id object){
    return [object isKindOfClass:[NSString class]] && [object rangeOfString:@"."].location != NSNotFound;
}

NSString* MBSEmptyString(id object){
    if (object == nil || [object isKindOfClass:[NSNull class]] ||
        ([object isKindOfClass:[NSString class]] && [object length] == 0)) {
        return @"";
    }
    
    return object;
}
#pragma mark 判断是否合法的
BOOL isVaildNumber(NSString * str)
{
    //正则判断
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.\n"] invertedSet];
    NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [str isEqualToString:filtered];
    
    return basicTest;

}

BOOL isEmojiFace(NSString * string)
{
 
        __block BOOL returnValue = NO;
    
        [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
         
         ^(NSString *substring,NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
             
             const unichar hs = [substring characterAtIndex:0];
             
             
             NSLog(@"hs  %c",hs);
             
             printf("hs==%02x\n",hs);
             
             // surrogate pair
             
             if (0xd800 <= hs && hs <= 0xdbff) {
                 
                 if (substring.length > 1) {
                     
                     const unichar ls = [substring characterAtIndex:1];
                     
                     const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                     
                     if (0x1d000 <= uc && uc <= 0x1f77f) {
                         
                         returnValue =YES;
                         
                     }
                     
                 }
                 
             }else if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 
                 NSLog(@"ls  %c",ls);
                 
                 printf("ls==%02x\n",ls);
                 
                 
                 if (ls == 0x20e3||ls ==0xfe0f) {
                     
                     returnValue =YES;
                     
                 }
                 
             }else {
                 
                 // non surrogate
                 /*
                 if (0x2100 <= hs && hs <= 0x27ff) {
                     
                     returnValue =YES;
                     
                 }else if (0x2B05 <= hs && hs <= 0x2b07) {
                     
                     returnValue =YES;
                     
                 }else if (0x2934 <= hs && hs <= 0x2935) {
                     
                     returnValue =YES;
                     
                 }else if (0x3297 <= hs && hs <= 0x3299) {
                     
                     returnValue =YES;
                     
                 }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                     
                     returnValue =YES;
                     
                 }
                 */
             }
             
         }];
        
        return returnValue;
        
    
}

