//
//  MessageUser.m
//  WeChat
//
//  Created by Fuwentao on 2017/5/19.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import "MessageUser.h"
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width

@implementation MessageUser
-(instancetype)init{
    self = [super init];
    if (self!=nil) {
        _contentFontSize = 16;
    }
    return self;
}
-(void)setContent:(NSString *)content{
    if (![content isEqualToString:_content]) {
        _content = content;
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:_contentFontSize]};
        _fream = [content boundingRectWithSize:CGSizeMake(ScreenWidth-160, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    }
}
@end
