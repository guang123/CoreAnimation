//
//  MainViewController.m
//  CoreAnimation
//
//  Created by Yx on 15/12/17.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "ViewAnimationViewController.h"
#import "LayeAnimationViewController.h"
#import "BezierViewController.h"
#import "DynamicsViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableViewMain;
@property (strong, nonatomic) NSMutableArray *arrDataSource;
@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    //设置视图控制器标题
    self.title = @"Main";
    _arrDataSource = [NSMutableArray arrayWithObjects:@"View动画",@"Layer动画",@"贝塞尔曲线",@"动力学", nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableViewMain reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"MainViewControllerCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.textColor=[UIColor colorWithRed:0x21/255.0f green:0x88/255.0f blue:0x68/255.0f alpha:1];
    cell.detailTextLabel.numberOfLines = 0;
    cell.textLabel.text = self.arrDataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 ){
    
    }else if (indexPath.row == 1){
        LayeAnimationViewController *propertyVC = [[LayeAnimationViewController alloc] initWithNibName:@"LayeAnimationViewController" bundle:nil];
        [self.navigationController pushViewController:propertyVC animated:YES];
    }else if (indexPath.row == 2){
        BezierViewController *bezierVC = [[BezierViewController alloc] initWithNibName:@"BezierViewController" bundle:nil];
        [self.navigationController pushViewController:bezierVC animated:YES];
    }else{
        DynamicsViewController *dynamicsVC = [[DynamicsViewController alloc] initWithNibName:@"DynamicsViewController" bundle:nil];
        [self.navigationController pushViewController:dynamicsVC animated:YES];
    }
}

@end
