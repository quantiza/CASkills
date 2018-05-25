//
//  SecondViewController.m
//  CASkills
//
//  Created by Long Yang on 2018/5/25.
//  Copyright © 2018年 Long Yang. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <CAAnimationDelegate>

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (IBAction)changeColor:(UIButton *)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position";
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 500)];
    animation.delegate = self;
    
    [self.colorLayer addAnimation:animation forKey:nil];
}

//动画做完要保持结束状态，否则会回到初始状态
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];  // 防止二次动画
    self.colorLayer.position = [anim.toValue CGPointValue];
    [CATransaction commit];
}

@end
































