//
//  DynamicsViewController.m
//  CoreAnimation
//
//  Created by Yx on 15/12/19.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//
/*说在前面
 
 UIDynamicAnimator      iOS 物理引擎，为动力项（UIDynamicItem）提供物理相关的功能和动画。
 UIDynamicBehavior      动力行为，为动力项提供不同的物理行为
 UIDynamicItem          动力项，相当于现实世界中的一个基本物体
 
 */
/*
 UIDynamicBehavior的子类
 UIAttachmentBehavior（吸附）
 UICollisionBehavior（碰撞）
 UIGravityBehavior（重力）
 UIPushBehavior（推动）
 UISnapBehavior（捕捉）
 UIDynamicItemBehavior，用来在item层级设定一些参数，比如item的摩擦，阻力，角阻力，弹性密度和可允许的旋转等等
 / 弹力，通常设置 0~1 之间
 @property (readwrite, nonatomic) CGFloat elasticity;
 
 // 摩擦力，0表示完全光滑无摩擦
 @property (readwrite, nonatomic) CGFloat friction;
 
 // 密度，一个 100x100 points（1 point 在 retina 屏幕上等于2像素，在普通屏幕上为1像素。）大小的物体，密度1.0，在上面施加 1.0 的力，会产生 100 point/平方秒 的加速度。
 @property (readwrite, nonatomic) CGFloat density;
 
 // 线性阻力，物体在移动过程中受到的阻力大小
 @property (readwrite, nonatomic) CGFloat resistance;
 
 // 旋转阻力，物体旋转过程中的阻力大小
 @property (readwrite, nonatomic) CGFloat angularResistance;
 
 // 是否允许旋转
 @property (readwrite, nonatomic) BOOL allowsRotation;
 
 */
#import "DynamicsViewController.h"

@interface DynamicsViewController ()<UICollisionBehaviorDelegate>
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
@property (weak, nonatomic) IBOutlet UIImageView *imageFlower;
@property (weak, nonatomic) IBOutlet UIImageView *imageFlower2;
@property (weak, nonatomic) IBOutlet UIImageView *imageFlower3;
@property (weak, nonatomic) IBOutlet UIImageView *imageFlower4;
@property (weak, nonatomic) IBOutlet UIImageView *imageFlower5;
@end

@implementation DynamicsViewController
@synthesize animator;
@synthesize attachmentBehavior;
@synthesize imageFlower;

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
     animator= [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [imageFlower setUserInteractionEnabled:YES];
    [imageFlower addGestureRecognizer:pan];
    [self addGravityBehavior];
    [self addCollisionBehavior];
    
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewHandler:)];
    [self.view addGestureRecognizer:viewTapGesture];
}

//添加重力行为
- (void)addGravityBehavior{
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.imageFlower2]]; // 创建一个重力行为
    //重力的方向
    gravity.angle = M_PI_2;
    //重力的加速度
    gravity.magnitude = 1;
    //设置重力的方向（是一个二维向量）
    //gravity.gravityDirection = CGVectorMake(-1, 1);//135度角
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.imageFlower2]];
    itemBehavior.elasticity = 0.8; // 改变弹性
    itemBehavior.allowsRotation = YES; // 允许旋转
    [itemBehavior addAngularVelocity:1 forItem:self.imageFlower2]; // 让物体旋转
    [self.animator addBehavior:itemBehavior];
    
    [self.animator addBehavior:gravity];
}

//添加碰撞行为
- (void)addCollisionBehavior{
    // 创建碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.imageFlower2]];
    collision.collisionDelegate = self;
    // 指定 Reference view 的边界为可碰撞边界
    //collision.translatesReferenceBoundsIntoBoundary = YES;
    // 添加一个椭圆为碰撞边界
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 320, 320)];
    CAShapeLayer *layerP = [CAShapeLayer layer];
    layerP.path = path.CGPath;
    layerP.fillColor = [UIColor clearColor].CGColor;
    layerP.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layerP];
    
    [collision addBoundaryWithIdentifier:@"circle" forPath:path];
    //UICollisionBehaviorModeItems: item和item碰撞；
    //UICollisionBehaviorModeBoundaries：item只和碰撞边界进行碰撞；
    //UICollisionBehaviorModeEverything: item和item之间会发生碰撞，也会和指定的边界发生碰撞。
    collision.collisionMode = UICollisionBehaviorModeEverything;
    [self.animator addBehavior:collision];
}

//吸附行为
- (void)gesture:(UIPanGestureRecognizer *)gesture{
    CGPoint location = [gesture locationInView:self.view];
    CGPoint boxLocation = [gesture locationInView:imageFlower];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            [animator removeAllBehaviors];
            // Create an attachment binding the anchor point (the finger's current location)
            // to a certain position on the view (the offset)
            UIOffset centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(imageFlower.bounds),
                                                 boxLocation.y - CGRectGetMidY(imageFlower.bounds));
            attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:imageFlower
                                                           offsetFromCenter:centerOffset
                                                           attachedToAnchor:location];
            attachmentBehavior.damping=0.5;//阻尼值
            attachmentBehavior.frequency=0.8;
            [animator addBehavior:attachmentBehavior];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [animator removeBehavior:attachmentBehavior];
            break;
        }
        default:
            [attachmentBehavior setAnchorPoint:[gesture locationInView:self.view]];
            break;
    }
}

//推动
- (void)tapViewHandler:(UITapGestureRecognizer *)gestureRecognizer
{
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.imageFlower4] mode:UIPushBehaviorModeInstantaneous];
   // CGPoint location = [gestureRecognizer locationInView:self.view];
    push.pushDirection = CGVectorMake(1, 1);
    [self.animator addBehavior:push];
}

#pragma mark - UICollisionBehaviorDelegate
// item 和边界结束碰撞
- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(id <NSCopying>)identifier
{
    // 结束碰撞为 imageFlower2 设置一个随机背景
    self.imageFlower2.backgroundColor = [UIColor colorWithRed:(float)rand() / RAND_MAX
                                                      green:(float)rand() / RAND_MAX
                                                       blue:(float)rand() / RAND_MAX
                                                      alpha:1];
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
