//
//  LayeAnimationViewController.m
//  CoreAnimation
//
//  Created by Yx on 15/12/17.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "LayeAnimationViewController.h"
#import "LayerBasicAnimationViewController.h"
#import "LayerFrameAnimationViewController.h"
#import "LayerTransitionViewController.h"
#import "LayerEmitterViewController.h"
#import "LayerSpringViewController.h"

@interface LayeAnimationViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableViewMain;
@property (strong, nonatomic) NSMutableArray *arrDataSource;
@end

@implementation LayeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    //设置视图控制器标题
    self.tableViewMain.rowHeight = 60;
    self.title = @"CAAnimation";
    _arrDataSource = [NSMutableArray arrayWithObjects:@"属性动画",@"转场动画",@"组合动画",@"其他图层动画", nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableViewMain reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"LayerAnimationViewControllerCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.textColor = [UIColor redColor];
    [tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, -1, 0)];
    if (indexPath.section == 0) {
        if(indexPath.row == 0 ){
            cell.textLabel.text = @"CABasicAnimation（基础动画）";
        }else{
            cell.textLabel.text = @"CAKeyframeAnimation（关键帧动画）";
        }
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"CATransition";
    }else if (indexPath.section == 2){
        cell.textLabel.text = @"CASpringAnimation";
    }else{
        cell.textLabel.text = @"CAEmitterLayer";
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if(indexPath.row == 0 ){
            //基础动画
            LayerBasicAnimationViewController *baseVC = [[LayerBasicAnimationViewController alloc] initWithNibName:@"LayerBasicAnimationViewController" bundle:nil];
            [self.navigationController pushViewController:baseVC animated:YES];
        }else{
            LayerFrameAnimationViewController *frameVC = [[LayerFrameAnimationViewController alloc] initWithNibName:@"LayerFrameAnimationViewController" bundle:nil];
            [self.navigationController pushViewController:frameVC animated:YES];
        }
    }else if (indexPath.section == 1){
        LayerTransitionViewController *transitionVC = [[LayerTransitionViewController alloc] initWithNibName:@"LayerTransitionViewController" bundle:nil];
        [self.navigationController pushViewController:transitionVC animated:YES];
    }else if (indexPath.section == 2 ){
        LayerSpringViewController *groupVC = [[LayerSpringViewController alloc] initWithNibName:@"LayerSpringViewController" bundle:nil];
        [self.navigationController pushViewController:groupVC animated:YES];
    }else{
        LayerEmitterViewController *emitterVC = [[LayerEmitterViewController alloc] initWithNibName:@"LayerEmitterViewController" bundle:nil];
        [self.navigationController pushViewController:emitterVC animated:YES];
    }
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] init];
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, ScreenWidth, 44);
    label.frame = CGRectMake(24, 10, ScreenWidth, 24);
    if (section == 0) {
        label.text = @"属性动画";
    }else if (section == 1){
        label.text = @"转场动画";
    }else if (section == 2){
        label.text = @"阻尼动画";
    }else{
        label.text = @"其他效果";
    }
    [headView addSubview:label];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


@end
