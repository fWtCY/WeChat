
//
//  EmotionTextAttachment.m
//  WeChat
//
//  Created by Fuwentao on 2017/5/8.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import "EmotionTextAttachment.h"

@implementation EmotionTextAttachment
-(CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    return CGRectMake(0, 0, _emotionSize.width, _emotionSize.height);
}
@end
