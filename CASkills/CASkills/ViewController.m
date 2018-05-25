//
//  ViewController.m
//  CASkills
//
//  Created by Long Yang on 2018/5/24.
//  Copyright © 2018年 Long Yang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CALayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@property (nonatomic, strong) CALayer *blueLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addSublayer];
    [self addImage];
//    [self customDraw];
//    self.redView.layer.zPosition = 1.0;
    [self presentationLayerTest];
}

- (void)addSublayer {
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.whiteView.layer addSublayer:self.blueLayer];
}

- (void)addImage {
    UIImage *image = [UIImage imageNamed:@"apple"];
//    self.view.layer.geometryFlipped = YES; //沿着底部排版
    self.whiteView.layer.contents = (__bridge id)image.CGImage;  //CGImage属性不是Cocoa对象（UIKit and Foundation）,是Core Foundation指针
}

// 使用layer的代理方法重绘，这里显示调用display与UIView不同
- (void) customDraw {
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.delegate = self;
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.whiteView.layer addSublayer:blueLayer];
    [blueLayer display];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)presentationLayerTest {
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    self.blueLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 3);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:self.blueLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    if ([self.blueLayer.presentationLayer hitTest:point]) {
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.blueLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.blueLayer.position = point;
        [CATransaction commit];
    }
}

@end
