//
//  OABezierPath.h
//  01-画板案例
//
//  Created by 黄坤 on 16/5/6.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OABezierPath : UIBezierPath
/**
 *  颜色属性
 *  专门用来存放当前路径自己的颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

@end
