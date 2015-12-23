//
//  LayerTransitionViewController.m
//  CoreAnimation
//
//  Created by Yx on 15/12/17.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "LayerTransitionViewController.h"

@interface LayerTransitionViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) NSArray *images;

@end

@implementation LayerTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CATransition";
    self.images = @[[UIImage imageNamed:@"1.png"],
                    [UIImage imageNamed:@"2.png"],
                    [UIImage imageNamed:@"3.png"],
                    [UIImage imageNamed:@"5.png"]];
}

//推入动画
- (IBAction)switchImage
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;//subtype 决定推入的方向
    [self.imageView.layer addAnimation:transition forKey:nil];
    [self switchArr];
    /*
    //水波动效果
    CATransition *transition = [CATransition animation];
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.duration = 1.5f;
    transition.type = @"rippleEffect";
    [[self.imageView layer] addAnimation:transition forKey:@"rippleEffect"];*/
}

//移入
- (IBAction)moveIn:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.endProgress = 0.5;//endProgress 动画结束位置
    [self.imageView.layer addAnimation:transition forKey:nil];
    [self switchArr];
    
}

//飞出
- (IBAction)reveal:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.startProgress = 0.5;//endProgress 动画开始位置
    //filter 过滤属性
    [self.imageView.layer addAnimation:transition forKey:nil];
    [self switchArr];
}

//消失
- (IBAction)fade:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    [self.imageView.layer addAnimation:transition forKey:nil];
    [self switchArr];
}

- (void)switchArr{
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % [self.images count];
    self.imageView.image = self.images[index];
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
