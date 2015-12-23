//
//  BezierViewController.m
//  CoreAnimation
//
//  Created by Yx on 15/12/19.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//
/*
 //初始化方法
 普通初始化方法
 + (instancetype)bezierPath;
 根据一个矩形画贝塞尔曲线。
 + (instancetype)bezierPathWithRect:(CGRect)rect;
 根据一个矩形画内切曲线。通常用它来画圆或者椭圆。
 + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;
 画矩形，但是这个矩形是可以画圆角的。第一个参数是矩形，第二个参数是圆角大小
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
 功能同上一个是一样的，但是可以指定某一个角画成圆角。像这种我们就可以很容易地给UIView扩展添加圆角的方法了。
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
 这个工厂方法用于画弧，参数说明如下： center: 弧线中心点的坐标 radius: 弧线所在圆的半径 startAngle: 弧线开始的角度值 endAngle: 弧线结束的角度值 clockwise: 是否顺时针画弧线
 + (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
 根据一个定义好的曲线初始化
 + (instancetype)bezierPathWithCGPath:(CGPathRef)CGPath;
 
 - (instancetype)init NS_DESIGNATED_INITIALIZER;
 - (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
 
 */
#import "BezierViewController.h"

@interface BezierViewController ()

@end

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bezier";
    [self drawRectPath];
    [self drawTrianglePath];
    [self drawCiclePath];
    [self drawRoundedRectPath];
    [self drawARCPath];
    [self drawSecondBezierPath];
    [self drawThirdBezierPath];
}

//画三角形
- (void)drawTrianglePath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(40, 20)];
    [path addLineToPoint:CGPointMake(30, 40)];
    [path closePath];//闭合曲线
    [self drawGraph:path];
}

//画矩形
- (void)drawRectPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(55, 20, 40,40)];
    [self drawGraph:path];
}

//画圆
- (void)drawCiclePath {
    //将40改为20就可以画出椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(115, 20, 40,40)];
    [self drawGraph:path];
}

//画一个角为圆角矩形
- (void)drawRoundedRectPath {
    //UIRectCornerTopRight 改为UIRectCornerAllCorners 变为四个角都为圆角的矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(170, 20, 40,  40) byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    [self drawGraph:path];
}

//画弧
#define   kDegreesToRadians(degrees)  ((M_PI * degrees)/ 180)
- (void)drawARCPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(250, 30)
                                                        radius:20
                                                    startAngle:0
                                                      endAngle:kDegreesToRadians(135)
                                                     clockwise:YES];
    [self drawGraph:path];
}

//画二次贝赛尔曲线：一个控制点
//曲线绘制公式http://www.cnblogs.com/jay-dong/archive/2012/09/26/2704188.html
- (void)drawSecondBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置一个起始点
    [path moveToPoint:CGPointMake(20, 130)];
    //添加二次曲线
    [path addQuadCurveToPoint:CGPointMake(100,130)
                 controlPoint:CGPointMake(80, 100)];
    [self drawGraph:path];
    
    UIBezierPath *pathR = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(80, 100, 1,1)];
    [self drawGraph:pathR];
    
}

//画三次贝赛尔曲线：两个控制点
- (void)drawThirdBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起始端点
    [path moveToPoint:CGPointMake(20, 200)];
    [path addCurveToPoint:CGPointMake(300, 200)
            controlPoint1:CGPointMake(160, 1)
            controlPoint2:CGPointMake(160, 300)];
    [self drawGraph:path];
    //控制点一
    UIBezierPath *pathR = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(160, 1, 1,1)];
    [self drawGraph:pathR];
    //控制点二
    UIBezierPath *pathR2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(160, 300, 1,1)];
    [self drawGraph:pathR2];
}


//绘制出线
- (void)drawGraph:(UIBezierPath *)bezierPath {
    
    CABasicAnimation *tAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tAnimation.fromValue = @0.0;
    tAnimation.toValue = @1.0;
    tAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    tAnimation.duration = 5;
    
    CAShapeLayer *layerP = [CAShapeLayer layer];
    layerP.path = bezierPath.CGPath;
    layerP.fillColor = [UIColor clearColor].CGColor;
    layerP.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layerP];
    
    [layerP addAnimation:tAnimation forKey:@"strokeEnd"];
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
