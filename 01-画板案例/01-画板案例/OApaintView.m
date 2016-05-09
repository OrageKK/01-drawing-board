//
//  OApaintView.m
//  01-画板案例
//
//  Created by 黄坤 on 16/5/6.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import "OApaintView.h"
#import "OABezierPath.h"

@interface OApaintView ()
/**
 *  绘制图形的路径
 */
@property (strong, nonatomic) OABezierPath *path;
/**
 *  装着所有路径的集合
 */
@property (strong, nonatomic) NSMutableArray<OABezierPath *> *pathsArrM;

@end


@implementation OApaintView

#pragma mark - 其他功能

/**
 *  清屏
 */
- (void)clearAllLines {
    
    // 1.清楚所有元素
    [self.pathsArrM removeAllObjects];
    
    // 2.重绘
    [self setNeedsDisplay];
    
}

/**
 *  回退
 */
- (void)back {
    
    // 1.将集合中最后一个元素路径 移除
    [self.pathsArrM removeLastObject];
    
    // 2.重绘
    [self setNeedsDisplay];
}
/**
 *  截屏
 */
- (void)snapPaintView{
    //1.开启图片图形上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    
    //获取上下文
    CGContextRef cxtRef = UIGraphicsGetCurrentContext();
    //将layer渲染到图形上下文中
    [self.layer renderInContext:cxtRef];
    
    
    //从上下文中获取图片
    UIImage *snapImg = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    // MARK: - 2判断自己的block是否有值,如果有,再执行
    if (self.paintBlock) {
        self.paintBlock(self, snapImg);
        
        
    }

}

#pragma mark - 开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *touch = touches.anyObject;
    //获取触摸点
    CGPoint loc = [touch locationInView:self];
    
    
    //设置为路径的起点
    //创建路径对象
    self.path = [OABezierPath bezierPath];
    
    //设置起点
    [self.path moveToPoint:loc];
    
    //将路径保存到集合中
    [self.pathsArrM addObject:self.path];
    
    //设置线宽
    self.path.lineWidth = self.lineW;
    
    //设置颜色
    // MARK: - 系统提供的类型里面没有关于颜色的属性
    // 自定义路径对象,增加一个用来存放颜色的属性
    self.path.lineColor = self.lineC;
    
    
}

#pragma mark - 手指移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *touch = touches.anyObject;
    //获取触摸点
    CGPoint loc = [touch locationInView:self];
    
    //将触摸点添加到路径上
    [self.path addLineToPoint:loc];
    
    //重绘
    [self setNeedsDisplay];
    
}

#pragma mark - 绘图代码
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.pathsArrM enumerateObjectsUsingBlock:^(OABezierPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //取出颜色进行设置
        [obj.lineColor setStroke];
        
        //统一设置线头样式和接头样式
        obj.lineCapStyle = kCGLineCapRound;
        obj.lineJoinStyle = kCGLineJoinRound;
        //渲染
        [obj stroke];
    }];
    
}
#pragma mark - 懒加载集合
- (NSMutableArray<UIBezierPath *> *)pathsArrM {
    
    if (_pathsArrM == nil) {
        _pathsArrM = [NSMutableArray array];
    }
    return _pathsArrM;
    
}

@end
