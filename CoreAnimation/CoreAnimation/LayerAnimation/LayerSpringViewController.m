//
//  LayerGroupViewController.m
//  CoreAnimation
//
//  Created by Yx on 15/12/18.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "LayerSpringViewController.h"
#import "TPCGooButton.h"

@interface LayerSpringViewController (){
    TPCGooButton *_gooButton1;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageBall;
@property (weak, nonatomic) IBOutlet UIImageView *batImageView;
@end

@implementation LayerSpringViewController
@synthesize batImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CASpringAnimation";
    
    UIImage *image1 = [UIImage imageNamed:@"birds_one"];
    UIImage *image2 = [UIImage imageNamed:@"birds_twp"];
    UIImage *image3 = [UIImage imageNamed:@"birds_thr"];
    NSArray *imageArr = @[image1,image2,image3];
    // 图片动画
    batImageView.image = image1;
    batImageView.animationImages = imageArr;
    batImageView.animationDuration = 0.5;
    [batImageView startAnimating];
    
    
    UIBezierPath *bezierP = [UIBezierPath bezierPath];
    [bezierP moveToPoint:batImageView.frame.origin];//设置起点
    [bezierP addLineToPoint:CGPointMake(190, 190)];
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        //[batImageView removeFromSuperview];
    }];
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path  = bezierP.CGPath;
    keyAnimation.duration = 3;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;//动画结束后保存最后位置
    [batImageView.layer addAnimation:keyAnimation forKey:nil];
    [CATransaction commit];
    
    /*别人的一个非常不错的粘贴球效果
    gooButton1= [[TPCGooButton alloc] initWithFrame:CGRectMake(100, 50, 25, 25)];
    [_gooButton1 setTitle:@"11" forState:UIControlStateNormal];
    [self.view addSubview:_gooButton1];*/
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [batImageView stopAnimating];
}

- (IBAction)showAction:(id)sender {
    //阻尼动画  iOS9之后出现IPA
    CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"position.y"];
    spring.damping = 5;//阻尼系数越大，停止越快
    spring.stiffness = 100;//弹性系数
    spring.mass = 1;//质量
    spring.initialVelocity = 0;//初始速率，动画视图的初始速度大小
    CGPoint toPointY = self.imageBall.layer.position;
    toPointY.y += 150;//移动距离
    spring.toValue = [NSValue valueWithCGPoint:toPointY];
    spring.duration = spring.settlingDuration;//结算时间
    [self.imageBall.layer addAnimation:spring forKey:@"position.y"];
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
