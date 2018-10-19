//
//  MBSTextField.m
//  MBSiPhone
//
//  Created by llbt on 13-12-10.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import "MBSTextField.h"
#import "MBAccessoryView.h"
#import <QuartzCore/QuartzCore.h>
#import "RegexKitLite.h"
#import "NSStringUtils.h"
//#import "UIColorAdditions.h"

//===========================================MBSTextFieldAgent=======================================================
@interface MBSTextFieldAgent : NSObject<UITextFieldDelegate>

@property (nonatomic, unsafe_unretained) MBSTextField *target;
@end

@implementation MBSTextFieldAgent{
    NSMutableString *changeStr;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   // textField.font = kTitleFont;
    if (_target.textFieldDelegate &&
        [_target.textFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
    {
        return [_target.textFieldDelegate textFieldShouldBeginEditing:textField];
    }
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_target.textFieldDelegate &&
        [_target.textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_target.textFieldDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (_target.textFieldDelegate &&
        [_target.textFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [_target.textFieldDelegate textFieldShouldEndEditing:textField];
    }
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
   // textField.font = kTitleFont;
    if (_target.textFieldDelegate &&
        [_target.textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_target.textFieldDelegate textFieldDidEndEditing:textField];
    }
}
#if 1
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_target.selfType == MBSPassword) {
        //密码输入框  不允许输入空格
        if ([string isEqualToString:@" "]) {
            return NO;
        }
    }
    
    if (changeStr==nil) {
        changeStr=[[NSMutableString alloc] initWithCapacity:2];
    }
    
//    if (_target.selfType==MBSMoney_type) {
//        if (changeStr.length == 0) {
//            if ([string isEqualToString:@"0"]) {
//                return NO;
//            }else{
//                //添加
//                [changeStr appendString:string];
//                return YES;
//            }
//        }
//    }
    
    if ((textField.keyboardType == UIKeyboardTypeDecimalPad)&&(_target.selfType==MBSMoney_type)) {
        if ( 1 == range.length && string.length == 0)
        {
            //删除
            [changeStr deleteCharactersInRange:range];
        }
        else
        {
            //添加
            [changeStr appendString:string];
        }
        NSString *str=[self moneyStringWithDigitStr:changeStr];
        
        NSString *str2=@"";
        
        if ([textField.text rangeOfString:@"."].location != NSNotFound) {
            if ( 1 == range.length && string.length == 0)
            {
                NSMutableString *tempStr=[[NSMutableString alloc] initWithString:textField.text];
                [tempStr deleteCharactersInRange:range];
                //删除
                if ([tempStr rangeOfString:@"."].location != NSNotFound) {
                    str2=[self format:[NSString stringWithFormat:@"%@",[tempStr substringFromIndex:([tempStr rangeOfString:@"."].location+1)]]];
                }
            }
            else
            {
                //添加
                str2=[self format:[NSString stringWithFormat:@"%@%@",[textField.text substringFromIndex:([textField.text rangeOfString:@"."].location+1)],string]];
            }
        }
        NSString *zheng=str2.length>0?@"":@"整";
        _target.textFieldFormattBack([NSString stringWithFormat:@"%@%@%@",str,str2,zheng]);
        
        if ([string isEqualToString:@"."] &&
            [textField.text rangeOfString:@"."].location != NSNotFound) {
            return NO;
        }
    }
    
    NSUInteger _textMaxLength = _target.textMaxLength;
    if (_textMaxLength == 0) {
        return YES;
    }
    
    if(_target.selfType == MBSAccountNum){
		NSString *text = textField.text;
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string replace:@" " with:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        
        newString =[text format4Space];
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        NSUInteger count = [newString componentsSeparatedByString:@" "].count;
        if (newString.length >= _textMaxLength+count) {
            return NO;
        }
        
        [textField setText:newString];
        NSLog(@"\ntext.length+count-1 ==%u\nrange.location==%u\nnewString.length==%u",text.length+count-1,range.location,newString.length);
        
        //移动光标删除
        if ( 1 == range.length && string.length == 0 &&range.location<=text.length+count-1)
        {
            NSUInteger targetCursorPosition = range.location + string.length;
            UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument]
                                                                      offset:targetCursorPosition];
            [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition:targetPosition]];
        }
        //添加
        if (string.length > 0 && range.location<text.length+count-1)
        {
            NSInteger index =0;
            NSLog(@"count::::%d",count);
            if (range.location==4||range.location==9||range.location==14||range.location==19||range.location==24||range.location==29||range.location==34) {
                index = 1;
            }
            NSUInteger targetCursorPosition = range.location+1+index;
            
            UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument]
                                                                      offset:targetCursorPosition];
            [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition:targetPosition]];
        }
        
        
        
        return NO;
    }
    
    if(_target.selfType == MBSPhoneNum){
		NSString *text = textField.text;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];

        string = [string replace:@" " with:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        
        newString =[text mobile344Format];
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        NSUInteger count = [newString componentsSeparatedByString:@" "].count;
        if (newString.length >= _textMaxLength+count) {
            return NO;
        }
        
        [textField setText:newString];
        NSLog(@"\ntext.length+count-1 ==%u\nrange.location==%u\nnewString.length==%u",text.length+count-1,range.location,newString.length);
        
        //移动光标删除
        if ( 1 == range.length && string.length == 0 &&range.location<=text.length+count-1)
        {
            NSUInteger targetCursorPosition = range.location + string.length;
            UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument]
                                                                      offset:targetCursorPosition];
            [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition:targetPosition]];
        }
        //添加
        if (string.length > 0 && range.location<text.length+count-1)
        {
            NSInteger index =0;
            NSLog(@"count::::%lu",count);
            if (range.location==3||range.location==8||range.location==13) {
                index = 1;
            }
            NSUInteger targetCursorPosition = range.location+1+index;
            
            UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument]
                                                                      offset:targetCursorPosition];
            [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition:targetPosition]];
        }
        
        
        
        return NO;
    }
    
//    if ( 1 == range.length && string.length == 0)
//	{
//		return YES; //删除
//        
//	}else{
        NSString * text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfRegex:@"[\u4e00-\u9fa5]" withString:@"#"];
        NSUInteger symbol = [[text componentsMatchedByRegex:@"\u2006"] count];
		if ( _textMaxLength > 0 && text.length - symbol > _textMaxLength )
		{
			return NO;
		}
		return YES;
//    }
}
#else
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"replacementString ===%@",string);
    NSLog(@"location===%u     length====%u",range.location,range.length);
    
    int _textMaxLength = _target.textMaxLength;
    if (_textMaxLength == 0) {
        return YES;
    }
    
    if(_target.selfType == MBSAccountNum){
		NSString *text = textField.text;
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string replace:@" " with:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        
        newString =[text format4Space];
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        int count = [newString componentsSeparatedByString:@" "].count;
        if (newString.length >= _textMaxLength+count) {
            return NO;
        }
        
        [textField setText:newString];
        NSLog(@"\ntext.length+count-1 ==%u\nrange.location==%u\nnewString.length==%u",text.length+count-1,range.location,newString.length);

//移动光标删除
        if ( 1 == range.length && string.length == 0 &&range.location<=text.length+count-1)
        {
            NSUInteger targetCursorPosition = range.location + string.length;
            UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument]
                                                                      offset:targetCursorPosition];
            [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition:targetPosition]];
        }
//添加
        if (string.length > 0 &&range.location<text.length+count-1)
        {
            NSInteger index =0;
            NSLog(@"count::::%d",count);
            if (range.location==4||range.location==9||range.location==14||range.location==19) {
                index = 1;
            }
            NSUInteger targetCursorPosition = range.location+1+index;
            
            UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument]
                                                                      offset:targetCursorPosition];
            [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition:targetPosition]];
        }

        
        
        return NO;
    }
    
//    if ( 1 == range.length && string.length == 0)
//	{
//		return YES; //删除
//        
//	}else{
        NSString * text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfRegex:@"[\u4e00-\u9fa5]" withString:@"#"];
        int symbol = [[text componentsMatchedByRegex:@"\u2006"] count];
		if ( _textMaxLength > 0 && text.length - symbol > _textMaxLength )
		{
			return NO;
		}
		return YES;
//    }
}


#endif
-(NSString *)format:(NSString *)comeStr{
    NSArray *datas = [NSArray arrayWithObjects:@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖", nil];
    NSMutableString *mulStr=[[NSMutableString alloc] initWithCapacity:2];
    
    if (comeStr.length==1) {
        int number=comeStr.intValue % 10;
        [mulStr insertString:[datas objectAtIndex:number] atIndex:mulStr.length];
        [mulStr insertString:@"角" atIndex:mulStr.length];
    }
    else if (comeStr.length>1){
        int numberOne=[comeStr substringToIndex:1].intValue;
        [mulStr insertString:[datas objectAtIndex:numberOne] atIndex:mulStr.length];
        [mulStr insertString:@"角" atIndex:mulStr.length];
        
        int numberTwo=[comeStr substringWithRange:NSMakeRange(1, 1)].intValue;
        [mulStr insertString:[datas objectAtIndex:numberTwo] atIndex:mulStr.length];
        [mulStr insertString:@"分" atIndex:mulStr.length];
    }
    return mulStr;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (_target.textFieldFormattBack) {
        _target.textFieldFormattBack(@"");
    }
    
    if (_target.textFieldDelegate &&
        [_target.textFieldDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [_target.textFieldDelegate textFieldShouldClear:textField];
    }
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"[%@]",textField.text);
    NSLog(@"%@",[textField.text componentsMatchedByRegex:@"\\S"]);
    
    if (_target.textFieldDelegate &&
        [_target.textFieldDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [_target.textFieldDelegate textFieldShouldReturn:textField];
    }
	return YES;
}
#pragma mark 将数字转化成大写金额
- (NSString *)moneyStringWithDigitStr:(NSString *)digitString
{
    NSArray *datas = [NSArray arrayWithObjects:@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖", nil];
    NSArray *infos = [NSArray arrayWithObjects:@"圆", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"万", nil];
    
    NSMutableString *processString = [[NSMutableString alloc] initWithString:digitString];
    
    if (!([processString rangeOfString:@"."].location==NSNotFound)) {
        [processString deleteCharactersInRange:[processString rangeOfString:[processString substringFromIndex:[processString rangeOfString:@"."].location]]];
    };
    
    NSMutableString *resultString = [NSMutableString string];
    int i = 0;
    NSUInteger j = processString.length;
    
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
        [processString deleteCharactersInRange:NSMakeRange(j, 1)];
    }
    
    NSString *moneyString = [NSString stringWithFormat:@"%@",resultString];
    NSError *error=nil;
    NSArray *expressions = [NSArray arrayWithObjects:@"零[拾佰仟]", @"零+亿", @"零+万", @"零+元", @"零+",@"亿万",nil];
    NSArray *changes = [NSArray arrayWithObjects:@"零", @"亿",@"万",@"",@"零",@"亿",nil];
    
    for (int k = 0; k < 6; k++)
    {
        NSRegularExpression *reg=[[NSRegularExpression alloc] initWithPattern:[expressions objectAtIndex:k] options:NSRegularExpressionCaseInsensitive error:&error];
        
        moneyString = [reg stringByReplacingMatchesInString:moneyString options:0 range:NSMakeRange(0, moneyString.length) withTemplate:[changes objectAtIndex:k]];
    }
    return moneyString;
}

@end

//===========================================MBSTextField=======================================================

@interface MBSTextField ()<MBAccessoryViewDelegate>{
    NSString *_lastText;
    BOOL _shouldConfigBorder;
    
    __weak id <UITextFieldDelegate> _origDelegate;
    
    BOOL _firstTimeSetDeleagte;
    MBSTextFieldAgent *_agent;
}

@end

@implementation MBSTextField
#pragma mark - Draw layout
- (void)showGlowing
{
    if (_shouldConfigBorder) {
        [self animateBorderColorFrom:(id)self.layer.borderColor to:(id)self.layer.shadowColor shadowOpacityFrom:(id)[NSNumber numberWithFloat:0.f] to:(id)[NSNumber numberWithFloat:1.f]];
    }
}
- (void)hideGlowing
{
    if (_shouldConfigBorder) {
        [self animateBorderColorFrom:(id)self.layer.borderColor to:(id)[UIColor lightGrayColor].CGColor shadowOpacityFrom:(id)[NSNumber numberWithFloat:1.f] to:(id)[NSNumber numberWithFloat:0.f]];
    }
}
- (void)_configBackground{
    _shouldConfigBorder = YES;
    
    //add by lgj
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    leftView.backgroundColor = [UIColor clearColor];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView.userInteractionEnabled = NO;
    
    self.borderStyle = UITextBorderStyleNone;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 4.f;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.layer.shadowColor = [UIColor orangeColor].CGColor;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:4.f].CGPath;
    self.layer.shadowOpacity = 0;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 3.f;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
- (void)animateBorderColorFrom:(id)fromColor to:(id)toColor shadowOpacityFrom:(id)fromOpacity to:(id)toOpacity
{
    CABasicAnimation *borderColorAnimation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    borderColorAnimation.fromValue = fromColor;
    borderColorAnimation.toValue = toColor;
    
    CABasicAnimation *shadowOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    shadowOpacityAnimation.fromValue = fromOpacity;
    shadowOpacityAnimation.toValue = toOpacity;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1.0f / 3.0f;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = @[borderColorAnimation, shadowOpacityAnimation];
    
    [self.layer addAnimation:group forKey:nil];
}
- (void)setBorderStyle:(UITextBorderStyle)borderStyle{
    if (borderStyle == UITextBorderStyleRoundedRect) {
        [self _configBackground];
    } else {
    }
    [super setBorderStyle:UITextBorderStyleNone];
}

#pragma mark - UITextField
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.inputAccessoryView = [[MBAccessoryView alloc] initWithDelegate:self];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.font = [UIFont systemFontOfSize:15];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        _shouldConfigBorder = NO;
        _agent = [[MBSTextFieldAgent alloc] init];
        _agent.target = self;
        
        _copyEnabled = YES;  //可复制，默认
        _firstTimeSetDeleagte = YES;
        self.delegate = _agent;
        
        
    }
    return self;
}
//把所有的粘贴功能，都设置行能够粘贴，暂时这样
-(void)setCopyEnabled:(BOOL)copyEnabled{
    _copyEnabled = YES;
}
- (id)init{
    self = [self initWithFrame:CGRectZero];
    return self;
}
- (void)setDelegate:(id<UITextFieldDelegate>)delegate{
    [super setDelegate:delegate];
    if (_firstTimeSetDeleagte) {
        _firstTimeSetDeleagte = NO;
        
    } else {
        _textFieldDelegate = delegate;
    }
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (_copyEnabled) {
        return [super canPerformAction:action withSender:sender];
    } else {
        return NO;
    }
}

#pragma mark 设置字体为kFieldTextFont
- (void)setFont:(UIFont *)font{
    [super setFont:[UIFont systemFontOfSize:17]];
}


-(void)forceChangeTextFont:(UIFont *)font{
    [super setFont:font];
}

- (BOOL)becomeFirstResponder{
    if (!_lastText) {
        _lastText = [self.text copy];
    }
    [self showGlowing];
    
    return [super becomeFirstResponder];
}
- (BOOL)resignFirstResponder{
    if([self isFirstResponder]){
        [self hideGlowing];
    }
    return [super resignFirstResponder];
}

- (void)setText:(NSString *)text{
    _lastText = text;
    [super setText:text];
}

#pragma mark - UIAccessoryViewDelegate Methods
- (void)accessoryViewDidPressedCancelButton:(MBAccessoryView *)view{
    [self resignFirstResponder];
    
    self.text = _lastText;
    _lastText = nil;
    
    if (self.textFieldDelegate &&
        [self.textFieldDelegate respondsToSelector:@selector(textFieldDidCancelEditing:)]) {
        [self.textFieldDelegate performSelector:@selector(textFieldDidCancelEditing:) withObject:self];
    }
    [self resignFirstResponder];
}
- (void)accessoryViewDidPressedDoneButton:(MBAccessoryView *)view{
    
    [self resignFirstResponder];
    
    if (self.text) {
        _lastText = [self.text copy];
    }
    
    if (self.textFieldDelegate &&
        [self.textFieldDelegate respondsToSelector:@selector(textFieldDidFinsihEditing:)]) {
        [self.textFieldDelegate performSelector:@selector(textFieldDidFinsihEditing:) withObject:self];
    }
    
}

// 默认金额输入框
+(instancetype)defaultMoneyFieldFrame:(CGRect)frame{
    
    MBSTextField *moneyField;
    moneyField = [[self alloc] initWithFrame:frame];
    moneyField.backgroundColor = [UIColor clearColor];
    moneyField.textMaxLength = 14;
    moneyField.font = [UIFont systemFontOfSize:15];
    moneyField.keyboardType=UIKeyboardTypeDecimalPad;
    return moneyField;
}

+ (instancetype)defaultFieldFrame:(CGRect)frame{
    
    MBSTextField *moneyField;
    moneyField = [[self alloc] initWithFrame:frame];
    moneyField.backgroundColor = [UIColor clearColor];
    moneyField.textMaxLength = 30;
    moneyField.font = [UIFont systemFontOfSize:15];
    return moneyField;
}
@end
