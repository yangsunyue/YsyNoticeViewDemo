//
//  FirstViewController.m
//  YsyNoticeViewDemo
//
//  Created by Yang on 17/3/10.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "FirstViewController.h"
#import "YsyWave.h"
#import "UIView+Extension.h"
#import "YsyNoticeView.h"



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YsyWave *waveView = [[YsyWave alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 300)];
    CGFloat DefaultY = 300 - 40;
    UIImageView *boat = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 30, DefaultY, 40, 40)];
    boat.image = [UIImage imageNamed:@"轮船"];
    
    [waveView addSubview:boat];
    waveView.waveBlock = ^(CGFloat y){
        boat.y = DefaultY + y;
    };
    [waveView startWaveAnimation];
    [self.view addSubview:waveView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)top:(UIButton *)sender {
    [YsyNoticeView showInfo:@"网络出错" withStyle:YsyNoticeStyleTop];
}
- (IBAction)bottomClick:(id)sender {
    [YsyNoticeView showInfo:@"网络出错" withStyle:YsyNoticeStyleBottom];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
