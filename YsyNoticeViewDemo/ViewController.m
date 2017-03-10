//
//  ViewController.m
//  YsyNoticeViewDemo
//
//  Created by Yang on 17/3/10.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "ViewController.h"
#import "YsyNoticeView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height


#define RGBColor(a,b,c,t) [UIColor colorWithRed:a/255.f green:b/255.f blue:c/255.f alpha:t]
#define RandomColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), (arc4random_uniform(255)/255.f))

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)  UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray new];
    [_dataArray addObject:@"TopBottom    Demo------->0"];
    [_dataArray addObject:@"TableView     Demo------->1"];
    [_dataArray addObject:@"TableView     Demo------->2"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = RGBColor(199, 242, 248, 1.0);
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:
        {
            FirstViewController *first = [[FirstViewController alloc] init];
            [self.navigationController pushViewController:first animated:YES];
        }
            break;
        case 1:
        {
            SecondViewController *first = [[SecondViewController alloc] init];
            [self.navigationController pushViewController:first animated:YES];
        }
            break;
        case 2:
        {
            ThirdViewController *first = [[ThirdViewController alloc] init];
            [self.navigationController pushViewController:first animated:YES];
        }
            break;
        default:
            break;
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
