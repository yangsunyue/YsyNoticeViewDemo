//
//  YsyNoticeView.h
//
//  Created by Yang on 17/3/9.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YsyNoticeStyle)
{
    YsyNoticeStyleTop = 0,
    YsyNoticeStyleTableView,
    YsyNoticeStyleBottom
} ;

@interface YsyNoticeView : UIView <UIGestureRecognizerDelegate>

+(void)showInfo:(NSString *)info withStyle:(YsyNoticeStyle)style;

+(void)showInfo:(NSString *)info withTableView:(UITableView *)tableView;

@end
