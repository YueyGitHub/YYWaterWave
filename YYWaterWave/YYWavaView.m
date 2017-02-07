//
//  YYWavaView.m
//  YYWaterWave
//
//  Created by Moon on 17/1/6.
//  Copyright © 2017年 mac mini. All rights reserved.
//

#import "YYWavaView.h"

@interface YYWavaView ()

@property (assign, nonatomic) CGFloat waveWidth;

@property (assign, nonatomic) CGFloat waveHeight;

@property (assign, nonatomic) CGFloat phase;

@property (assign, nonatomic) CADisplayLink *displayLink;

@property (assign, nonatomic) CAShapeLayer *waveSinLayer;

@property (assign, nonatomic) CAShapeLayer *waveCircleLayer;

@end

@implementation YYWavaView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.waveWidth = 0;
        self.waveHeight = 0;
        self.phase = 0;
        
        [self setupUI];
        
    }
    return self;
}

- (void)setWaveWidth:(CGFloat)waveWidth {
    waveWidth = [UIScreen mainScreen].bounds.size.width;
    _waveWidth = waveWidth;
}

- (void)setWaveHeight:(CGFloat)waveHeight {
    waveHeight = 10;
    _waveHeight = waveHeight;
}

- (void)setupUI {
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePath)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode: NSRunLoopCommonModes];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
    shapeLayer.fillColor = [[UIColor blueColor] CGColor];
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shapeLayer];
    self.waveSinLayer = shapeLayer;

    
    //先画一个圆
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor =   [UIColor redColor].CGColor;      // 填充色
    layer.strokeColor = [UIColor grayColor].CGColor;     // 边框颜色
    layer.lineWidth = 1.0f;
    layer.lineCap = kCALineCapRound;    //线框类型
    [self.layer addSublayer:layer];
    self.waveCircleLayer = layer;
    
}

- (void)updatePath{
    self.phase += 5.0;
    self.waveSinLayer.path = [self createSinPath].CGPath;
}

/**
 *可以看到在(-2π , 2π )的范围类，y值在[-1, 1]之间变化。
 *以正弦曲线为例，它可以表示为y=Asin(ωx+φ)+k，公式中各符号表示的含义：
 *A–振幅，即波峰的高度。
 *(ωx+φ)–相位，反应了变量y所处的位置。
 *φ–初相，x=0时的相位，反映在坐标系上则为图像的左右移动。
 *k–偏距，反映在坐标系上则为图像的上移或下移。
 *ω–角速度，控制正弦周期(单位角度内震动的次数)。
 */
- (UIBezierPath *)createSinPath {
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    CGFloat radius = 20;
    CGRect  rect = CGRectMake(50, 50, 50, 50);
    
    for (CGFloat x = 0; x < _waveWidth + 1; x += 1) {
        endX=x;
        CGFloat y = _waveHeight * sinf(2 * M_PI * x / _waveWidth + self.phase * M_PI/_waveWidth) + _waveHeight;
        if (x == 0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
        
        if (x == _waveWidth / 2) {
            rect = CGRectMake(x - radius, y - radius*2, radius*2, radius*2);
        }
    }
    
    CGFloat endY = _waveHeight * 2 + 10;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    
    
    UIBezierPath *beizPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    self.waveCircleLayer.path = beizPath.CGPath;
    
    return wavePath;
}

@end
