//
//  CustomTextView.m
//  WeChat
//
//  Created by Fuwentao on 2017/5/8.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView

-(CGRect)caretRectForPosition:(UITextPosition *)position{
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.size.height = 25;
    originalRect.size.width = 5;
    return originalRect;
}

@end
