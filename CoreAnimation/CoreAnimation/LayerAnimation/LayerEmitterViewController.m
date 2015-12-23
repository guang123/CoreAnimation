//
//  LayerEmitterViewController.m
//  CoreAnimation
//
//  Created by Yx on 15/12/17.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//
/*****************CAEmitterLayer属性****************************************************
emitterCells                    粒子单元数组
 
birthRate                       粒子创建速率 默认为1/s

lifetime                        粒子存活时间 默认为1s
 
velocity                        粒子的运动速度
 
scale                           粒子的缩放大小
 
spin                            粒子的旋转位置
 
seed                            初始化随机的粒子种子

emitterPosition                 发射器在xy平面的中心位置

emitterZPosition                发射器在Z平面的位置

emitterSize                     发射器的尺寸大小

emitterDepth                    发射器的深度，在某些模式下会产生立体效果

emitterMode                     发射器的发射模式
 kCAEmitterLayerPoints          从发射器中发出
 kCAEmitterLayerOutline         从发射器边缘发出
 kCAEmitterLayerSurface         从发射器表面发出
 kCAEmitterLayerVolume          从发射器中点发出
 
renderMode                      发射器渲染模式
 kCAEmitterLayerUnordered       粒子是无序出现的，多个发射源将混合
 kCAEmitterLayerOldestFirst     声明久的粒子会被渲染在最上层
 kCAEmitterLayerOldestLast      年轻的粒子会被渲染在最上层
 kCAEmitterLayerBackToFront     粒子的渲染按照Z轴的前后顺序进行
 kCAEmitterLayerAdditive        会进行粒子混合
 
 
emitterShape                    发射器的形状
 kCAEmitterLayerPoint           点的形状，粒子从一个点发出
 kCAEmitterLayerLine            线的形状，粒子从一条线发出
 kCAEmitterLayerRectangle       矩形形状，粒子从一个矩形中发出
 kCAEmitterLayerCuboid          立方体形状，会影响Z平面的效果
 kCAEmitterLayerCircle          圆形，粒子会在圆形范围发射
 kCAEmitterLayerSphere          球型
*************************************************************************************/

/*****************CAEmitterCell属性****************************************************
+ (instancetype)emitterCell 类方法创建粒子
 
name                设置发射单元的名称
 
enabled             是否允许发射器渲染
 
birthRate           粒子的创建速率
 
lifetime            粒子的生存时间
 
lifetimeRange       粒子的生存时间容差
 
emissionLatitude    粒子在Z轴方向的发射角度
 
emissionLongitude   粒子在xy平面的发射角度
 
emissionRange       粒子发射角度的容差
 
velocity            粒子的速度
 
velocityRange       粒子速度的容差

xAcceleration       向右
yAcceleration       向下
zAcceleration       x，y，z三个方向的加速度 数值越大速度越快

scale
scaleRange
scaleSpeed          缩放大小，缩放容差和缩放速度
 
spin
spinRange           旋转度与旋转容差
 
color               粒子的颜色
 
redRange
greenRange
blueRange
alphaRange          粒子在rgb三个色相上的容差和透明度的容差
 
redSpeed
greenSpeed
blueSpeed
alphaSpeed          粒子在RGB三个色相上的变化速度和透明度的变化速度
 
contents            渲染粒子，可以设置为一个CGImage的对象
 
contentsRect
 *************************************************************************************/

#import "LayerEmitterViewController.h"

@interface LayerEmitterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *viewMain;

@end

@implementation LayerEmitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CAEmitterLayer";
    //粒子发射器
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.birthRate = 5;
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(120,-20);
    emitter.emitterMode = kCAEmitterLayerSurface;
    emitter.emitterShape = kCAEmitterLayerLine;
    [self.view.layer insertSublayer:emitter atIndex:0];
    
    CAEmitterLayer *emitter1 = [CAEmitterLayer layer];
    emitter1.birthRate = 8;
    //kCAEmitterLayerAdditive，它实现了这样一个效果：合并粒子重叠部分的亮度使得看上去更亮
    emitter1.renderMode = kCAEmitterLayerAdditive;
    emitter1.emitterPosition = CGPointMake(50,-20);
    emitter1.emitterMode = kCAEmitterLayerSurface;
    emitter1.emitterShape = kCAEmitterLayerLine;
    [self.view.layer insertSublayer:emitter1 atIndex:0];
    
    
    //创建雪花类型的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake.name = @"snow";
    //粒子的透明度每过一秒就是减少0.4
    //snowflake.alphaSpeed = - 0.01;
    snowflake.scale = 0.08;
    snowflake.scaleSpeed = 0.03;
    //粒子参数的速度乘数因子
    snowflake.birthRate = 3.0;
    snowflake.lifetime = 120.0;
    //粒子速度
    snowflake.velocity = 30.0;
    //粒子的速度范围
    snowflake.velocityRange = 10;
    //粒子y方向的加速度分量
    //重力加速方向,y代表竖直,x为横向,数值越大,速度越快
    snowflake.yAcceleration = 2;
    //周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;
    //图片旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents = (id)[[UIImage imageNamed:@"snowflake.png"] CGImage];
    //设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000] CGColor];
    
    CAEmitterCell *snowflake1 = [CAEmitterCell emitterCell];
    snowflake1.name = @"snow";
    snowflake1.birthRate = 2.0;
    snowflake1.lifetime = 120.0;
    snowflake1.velocity = 50.0;
    snowflake1.velocityRange = 10;
    snowflake1.yAcceleration = 2;
    snowflake1.emissionRange = 0.5 * M_PI;
    snowflake1.spinRange = 0.25 * M_PI;
    snowflake1.contents = (id)[[UIImage imageNamed:@"snowflake.png"] CGImage];
    
    emitter.emitterCells = @[snowflake,snowflake1];
    emitter1.emitterCells = @[snowflake,snowflake1];
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
