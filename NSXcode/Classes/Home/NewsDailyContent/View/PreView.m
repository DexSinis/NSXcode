//
//  PreView.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/29.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "PreView.h"

@implementation PreView {
    CAShapeLayer *circleLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        circleLayer = [[CAShapeLayer alloc] init];
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeColor = [UIColor grayColor].CGColor;
        circleLayer.lineWidth = 10.f;
        circleLayer.path = [UIBezierPath bezierPathWithArcCenter:self.center radius:80 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
        circleLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:circleLayer];
        [self loadingAnimation];
    }
    return  self;
}

- (void)loadingAnimation {
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[strokeStartAnimation,strokeEndAnimation];
    group.repeatCount = 10;
    group.duration = 2.4;
    [circleLayer addAnimation:group forKey:nil];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
