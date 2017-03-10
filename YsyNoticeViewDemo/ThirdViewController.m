//
//  ThirdViewController.m
//  YsyNoticeViewDemo
//
//  Created by Yang on 17/3/10.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "ThirdViewController.h"
#import "UIView+Extension.h"
#import "YsyWave.h"
#import "mjrefresh.h"
#import "YsyNoticeView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height
#define RGBColor(a,b,c,t) [UIColor colorWithRed:a/255.f green:b/255.f blue:c/255.f alpha:t]

@interface ThirdViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)  UITableView *tableView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 300, SCREEN_WIDTH, SCREEN_HIGHT - 64 - 300) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
//    _tableView.tableHeaderView = waveView;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    _tableView.backgroundColor = RGBColor(199, 242, 248, 1.0);
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 22;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *resultId = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:resultId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resultId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"📚🍎🌰📱📺📚🍎🌰📱📺📚🍎🌰📱📺%ld", indexPath.row];
    return cell;
}

- (void)refresh{
    [_tableView.header beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.header endRefreshing];
        [YsyNoticeView showInfo:@"为您更新了48条数据" withTableView:_tableView];
    });
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
