//
//  MessageTableViewCell.m
//  WeChat
//
//  Created by Fuwentao on 2017/5/19.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import "MessageTableViewCell.h"
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define EdgeSize      10
#define HeadImageSize 40
@interface MessageTableViewCell(){
    UIImageView *_headImage;
    UIImageView *_backgroudImgae;
    UILabel     *_messageLable;
}
@end
@implementation MessageTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self!=nil) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        _headImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        _backgroudImgae = [[UIImageView alloc]initWithFrame:CGRectZero];
        _messageLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _messageLable.backgroundColor = [UIColor clearColor];
        _messageLable.textColor = [UIColor blackColor];
        _messageLable.numberOfLines = 0;
        [self.contentView addSubview:_headImage];
        [self.contentView addSubview:_backgroudImgae];
        [self.contentView addSubview:_messageLable];
    }
    return self;
}
-(void)setMessageUser:(MessageUser *)messageUser{
    if (messageUser!=nil) {
        _messageUser = messageUser;
        _messageLable.font = [UIFont systemFontOfSize:_messageUser.contentFontSize];
        [self setNeedsLayout];
    }
}
-(void)layoutSubviews{
    UIImage *selfImage = [UIImage imageNamed:@"chatfrom_bg_normal"];
    UIImage *otherImage = [UIImage imageNamed:@"chatto_bg_normal"];
    UIImage *selectImage = _messageUser.selfOrOther ?selfImage:otherImage;
    selectImage = [selectImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 23, 9, 23)];
    _backgroudImgae.image = selectImage;
    _headImage.image = [UIImage imageNamed:_messageUser.icon];
    _messageLable.text = _messageUser.content;
    if (_messageUser.selfOrOther) {
        _headImage.frame = CGRectMake(ScreenWidth-HeadImageSize-EdgeSize, EdgeSize, HeadImageSize, HeadImageSize);
        
        _backgroudImgae.frame = CGRectMake(ScreenWidth-HeadImageSize-EdgeSize*2-_messageUser.fream.size.width-35, EdgeSize, _messageUser.fream.size.width+35, _messageUser.fream.size.height+20);
        
        _messageLable.frame = CGRectMake(ScreenWidth-HeadImageSize-EdgeSize*2-_messageUser.fream.size.width-20, EdgeSize*2, _messageUser.fream.size.width, _messageUser.fream.size.height);
    }else{
       _headImage.frame = CGRectMake(EdgeSize, EdgeSize, HeadImageSize, HeadImageSize);
  
        _backgroudImgae.frame = CGRectMake(HeadImageSize+EdgeSize*2, EdgeSize, _messageUser.fream.size.width+35, _messageUser.fream.size.height+20);
        _messageLable.frame = CGRectMake(HeadImageSize+EdgeSize*2+20, EdgeSize*2, _messageUser.fream.size.width, _messageUser.fream.size.height);
    }
}

@end
