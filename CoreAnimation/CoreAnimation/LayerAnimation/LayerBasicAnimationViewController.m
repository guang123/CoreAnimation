//
//  LayerPropertyAnimationViewController.m
//  CoreAnimation
//
//  Created by Yx on 15/12/17.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "LayerBasicAnimationViewController.h"

@interface LayerBasicAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@end

@implementation LayerBasicAnimationViewController
@synthesize viewMain;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CABasicAnimation";
    //画线动画
    CABasicAnimation *tAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tAnimation.fromValue = @0.0;
    tAnimation.toValue = @1.0;
    tAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    tAnimation.duration = 10;
    
    UIBezierPath *bezierP = [UIBezierPath bezierPath];
    [bezierP moveToPoint:CGPointMake(20, 500)];
    [bezierP addCurveToPoint:CGPointMake(80, 300) controlPoint1:CGPointMake(140, 300) controlPoint2:CGPointMake(300, 300)];
    
    CAShapeLayer *layerP = [CAShapeLayer layer];
    layerP.path = bezierP.CGPath;
    layerP.fillColor = [UIColor clearColor].CGColor;
    layerP.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layerP];
    [layerP addAnimation:tAnimation forKey:nil];

    
}
//平移
- (IBAction)moveAction:(id)sender {
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue =  [NSValue valueWithCGPoint: viewMain.layer.position];
    CGPoint toPoint = viewMain.layer.position;
    toPoint.y += 100;//移动距离
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.duration = 2.0f;//动画时间
    //fillMode的作用就是决定当前对象过了非active时间段的行为。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用http://blog.csdn.net/yongyinmg/article/details/38756079
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//动画结束后保存最后位置
    [viewMain.layer addAnimation:animation forKey:@"position"];
}

//缩放
- (IBAction)scalingAction:(id)sender {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = 2.0f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//动画缓冲
    scaleAnimation.autoreverses = NO;   //是否重播，原动画的倒播
    [viewMain.layer addAnimation:scaleAnimation forKey:@"opacity"];
}

//渐变
- (IBAction)gradualChange:(id)sender {//opaque
    CABasicAnimation *opaqueAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opaqueAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opaqueAnimation.toValue = [NSNumber numberWithFloat:0.1];
    opaqueAnimation.duration = 2;
    opaqueAnimation.autoreverses = YES;//动画是否重播（原动画倒播）
    opaqueAnimation.repeatCount = 2;//动画重复次数
    [viewMain.layer addAnimation:opaqueAnimation forKey:@"opacity"];
}

//旋转
- (IBAction)rotationAction:(id)sender {
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 4];
    rotationAnimation.duration = 2.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]; //开始快，结尾慢
    [viewMain.layer addAnimation:rotationAnimation forKey:@"transform.rotation.z"];
    
    /*旋转
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    [viewMain.layer addAnimation:animation forKey:nil];*/
}

//抖动
- (IBAction)shakeAction:(id)sender {
    CABasicAnimation* shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-0.2];
    shakeAnimation.toValue = [NSNumber numberWithFloat:+0.2];
    shakeAnimation.duration = 0.1f;
    shakeAnimation.repeatCount = 4/3/0.1f;
    shakeAnimation.autoreverses = YES;
    viewMain.layer.allowsEdgeAntialiasing = YES;//ios7之后抗锯齿
    [viewMain.layer addAnimation:shakeAnimation forKey:@"transform.rotation.z"];
}

//组动画
- (IBAction)groupAction:(id)sender {
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 4];
    rotationAnimation.duration = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]; //开始快，结尾慢
    
    CABasicAnimation *opaqueAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opaqueAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opaqueAnimation.toValue = [NSNumber numberWithFloat:0.1];
    opaqueAnimation.duration = 1;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2.0f;
    [animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, opaqueAnimation, nil]];
    
    //将上述两个动画编组
    [viewMain.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

//暂停layer上面的动画
- (IBAction)pauseLayer:(id)sender
{
    CFTimeInterval pausedTime = [viewMain.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    viewMain.layer.speed = 0.0;
    viewMain.layer.timeOffset = pausedTime;
}


//继续layer上面的动画
- (IBAction)resumeLayer:(id)sender
{
    CFTimeInterval pausedTime = [viewMain.layer timeOffset];
    viewMain.layer.speed = 1.0;
    viewMain.layer.timeOffset = 0.0;
    viewMain.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [viewMain.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    viewMain.layer.beginTime = timeSincePause;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
