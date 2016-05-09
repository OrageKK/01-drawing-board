//
//  OApaintView.h
//  01-画板案例
//
//  Created by 黄坤 on 16/5/6.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OApaintView;
// MARK: - 1.给block起别名
typedef void(^OApaintViewBlock)(OApaintView *, UIImage *);

@interface OApaintView : UIView

// MARK: - 增加代理属性
//@property (nonatomic, weak) id<HMPaintViewDelegate> delegate;

// MARK: - 1.2 定义block变量
@property (nonatomic, copy) OApaintViewBlock paintBlock;


/**
 *  用来接收slider的值,设置线宽
 */
@property (nonatomic, assign) float lineW;

/**
 *  用来接收颜色的属性,设置颜色
 */
@property (nonatomic, strong) UIColor *lineC;


#pragma mark - 提供一个方法清屏
/**
 *  清屏
 */
- (void)clearAllLines;

/**
 *  回退
 */
- (void)back;

/**
 *  截屏功能
 */
- (void)snapPaintView;



@end
