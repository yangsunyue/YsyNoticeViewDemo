//
//  YsyNoticeView.m
//
//  Created by Yang on 17/3/9.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "YsyNoticeView.h"
#import "UIView+Extension.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height


#define RGBColor(a,b,c,t) [UIColor colorWithRed:a/255.f green:b/255.f blue:c/255.f alpha:t]
#define RandomColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), (arc4random_uniform(255)/255.f))

CGFloat height = 65.0;
CGFloat bottomHeight = 30;

@interface YsyNoticeView ()

+(void)creatTopView:(NSString *)info;
+(void)creatTableNoticeView:(NSString *)info;

@end

@implementation YsyNoticeView

+ (void)showInfo:(NSString *)info withStyle:(YsyNoticeStyle)style{
    if (style == YsyNoticeStyleTop) {
        [self creatTopView:info];
    }else if (style == YsyNoticeStyleTableView) {
        [self creatTableNoticeView:info];
    }else if (style == YsyNoticeStyleBottom) {
        [self creatBottomNoticeView:info];
    }
}
#pragma mark - 顶部提示
+ (void)creatTopView:(NSString *)info{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -height, SCREEN_WIDTH, height)];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor = [UIColor whiteColor];
    
    topView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    topView.layer.shadowOpacity = 1;
    topView.layer.shadowRadius = 5;
    topView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64 - 20 - 11 , 20, 20)];
    icon.image = [UIImage imageNamed:@"提示"];
    [topView addSubview:icon];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + 20 + 10, 64 - 20 - 11, SCREEN_WIDTH - 40 - 20, 20)];
    textLabel.text = info;
    textLabel.textColor = [UIColor blackColor];
    textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [topView addSubview:textLabel];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    
    [[pan rac_gestureSignal] subscribeNext:^(UIPanGestureRecognizer *pan) {
        NSLog(@"%@", pan);
        [UIView animateWithDuration:0.7 animations:^{
            pan.view.frame = CGRectMake(0, -height, SCREEN_WIDTH, height);
        } completion:^(BOOL finished) {
            [pan.view removeFromSuperview];
        }];
        [pan.view removeGestureRecognizer:pan];
    }];
    [topView addGestureRecognizer:pan];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:topView];
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.3 options:0 animations:^{
        topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    } completion:^(BOOL finished) {
        if (finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.7 animations:^{
                    topView.frame = CGRectMake(0, -height, SCREEN_WIDTH, height);
                } completion:^(BOOL finished) {
                    [topView removeFromSuperview];
                }];
            });
        }
    }];
}



#pragma mark - 导航栏下面的提示通常用于tableView
+ (void)creatTableNoticeView:(NSString *)info{
    UIView *tableviewTopView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, SCREEN_WIDTH, 0)];
    tableviewTopView.backgroundColor = RGBColor(15, 163, 233, 1.0);
    tableviewTopView.clipsToBounds = YES;
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH - 20 - 20, 20)];
    textLabel.text = info;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [tableviewTopView addSubview:textLabel];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:tableviewTopView];
    
    [UIView animateWithDuration:0.8 animations:^{
        tableviewTopView.height = 30;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.7 animations:^{
                tableviewTopView.height = 0;
            } completion:^(BOOL finished) {
                [tableviewTopView removeFromSuperview];
            }];
        });
    }];
}

#pragma mark - TableView的提示
+(void)showInfo:(NSString *)info withTableView:(UITableView *)tableView{
    UIView *tableviewTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 0)];
    tableviewTopView.backgroundColor = RGBColor(15, 163, 233, 1.0);
    tableviewTopView.clipsToBounds = YES;
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH - 20 - 20, 20)];
    textLabel.text = info;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [tableviewTopView addSubview:textLabel];
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [tableView addSubview:tableviewTopView];
    
    [UIView animateWithDuration:0.8 animations:^{
        tableviewTopView.height = 30;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.7 animations:^{
                tableviewTopView.height = 0;
            } completion:^(BOOL finished) {
                [tableviewTopView removeFromSuperview];
            }];
        });
    }];
}


#pragma mark - 底部提示
+ (void)creatBottomNoticeView:(NSString *)info{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT - bottomHeight - 40 - 49, SCREEN_WIDTH, bottomHeight)];
    bottomView.userInteractionEnabled = YES;
    bottomView.backgroundColor = [UIColor whiteColor];
    
    bottomView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowRadius = 5;
    bottomView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (bottomHeight - 20) / 2 , 20, 20)];
    icon.image = [UIImage imageNamed:@"提示"];
    [bottomView addSubview:icon];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + 20 + 10, (bottomHeight - 20) / 2, SCREEN_WIDTH - 40 - 20, 20)];
    textLabel.text = info;
    textLabel.textColor = [UIColor blackColor];
    textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [bottomView addSubview:textLabel];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    
    [[pan rac_gestureSignal] subscribeNext:^(UIPanGestureRecognizer *pan) {
        NSLog(@"%@", pan);
        [UIView animateWithDuration:0.7 animations:^{
            pan.view.frame = CGRectMake(0, -height, SCREEN_WIDTH, height);
        } completion:^(BOOL finished) {
            [pan.view removeFromSuperview];
        }];
        [pan.view removeGestureRecognizer:pan];
    }];
    [bottomView addGestureRecognizer:pan];
    bottomView.alpha = 0.1;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:bottomView];
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.3 options:0 animations:^{
        bottomView.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.7 animations:^{
                    bottomView.alpha = 0;
                } completion:^(BOOL finished) {
                    [bottomView removeFromSuperview];
                }];
            });
        }
    }];
}

@end
