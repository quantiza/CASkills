//
//  SecondViewController.m
//  CASkills
//
//  Created by Long Yang on 2018/5/25.
//  Copyright © 2018年 Long Yang. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


//basic animation
- (IBAction)changeColor:(UIButton *)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position";
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 500)];
    animation.duration = 3.0;
    animation.delegate = self;
    
    [self.blueView.layer addAnimation:animation forKey:nil];
}

//keyframe animation
- (IBAction)keyframeAnimation:(id)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 2.0;
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(100, 100)],
                         [NSValue valueWithCGPoint:CGPointMake(300, 100)],
                         [NSValue valueWithCGPoint:CGPointMake(300, 500)],
                         [NSValue valueWithCGPoint:CGPointMake(100, 500)],
                         [NSValue valueWithCGPoint:CGPointMake(100, 100)]
                         ];
    [self.blueView.layer addAnimation:animation forKey:nil];
}

// virtual property
- (IBAction)virtualPropertyTest:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.toValue = @(2*M_PI);
    animation.duration = 1.0;
    [self.blueView.layer addAnimation:animation forKey:nil];
}

- (IBAction)groupAnimationTest:(id)sender {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100, 200)];
    [bezierPath addCurveToPoint:CGPointMake(100, 500) controlPoint1:CGPointMake(-100, 275) controlPoint2:CGPointMake(300, 425)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.lineWidth = 3.0;
    [self.view.layer addSublayer:pathLayer];
    
    self.blueView.layer.position = CGPointMake(100, 200);
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"transform.rotation";
    animation2.toValue = @(4 * M_PI);
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 3.0;
    [self.blueView.layer addAnimation:groupAnimation forKey:nil];
}

//动画做完要保持结束状态，否则会回到初始状态
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];  // 防止二次动画
    self.blueView.layer.position = [anim.toValue CGPointValue];
    [CATransaction commit];
}

@end
































