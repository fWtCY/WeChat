//
//  MessageTableViewCell.h
//  WeChat
//
//  Created by Fuwentao on 2017/5/19.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUser.h"

@interface MessageTableViewCell : UITableViewCell
@property(nonatomic,strong)MessageUser *messageUser;
@end
