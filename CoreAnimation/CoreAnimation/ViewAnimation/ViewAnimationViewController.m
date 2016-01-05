//
//  ViewAnimationViewController.m
//  CoreAnimation
//
//  Created by Yx on 15/12/17.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "ViewAnimationViewController.h"

@interface ViewAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewAnimationViewController
@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"View";
    self.view.backgroundColor=[UIColor yellowColor];
    [UIView animateWithDuration:2 animations:^(void){
        self.view.backgroundColor = [UIColor redColor];
    }];
    //绘制圆角方法一
    imageView.layer.cornerRadius = imageView.frame.size.width/2.0;
    imageView.layer.masksToBounds = YES;
    
    //绘制圆角方法二
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:imageView.bounds];
    layer.path = aPath.CGPath;
    imageView.layer.mask = layer;
    
    //绘制圆角方法三 通过遮罩。这里不演示嘿嘿
    
    //扩展UIImageView 通过Quartz 2D绘制
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
