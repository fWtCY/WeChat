//
//  EmotionTextAttachment.h
//  WeChat
//
//  Created by Fuwentao on 2017/5/8.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionTextAttachment : NSTextAttachment
@property(nonatomic,strong)NSString *emotionTag;
@property(nonatomic,assign)CGSize emotionSize;

@end
