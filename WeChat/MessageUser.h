//
//  MessageUser.h
//  WeChat
//
//  Created by Fuwentao on 2017/5/19.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MessageUser : NSObject
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,assign) BOOL selfOrOther;

@property(nonatomic,assign,readonly)CGFloat contentFontSize;
@property(nonatomic,assign,readonly)CGRect fream;
@end
