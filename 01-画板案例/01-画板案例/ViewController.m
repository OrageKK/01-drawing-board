//
//  ViewController.m
//  01-画板案例
//
//  Created by 黄坤 on 16/5/6.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "OApaintView.h"
@interface ViewController ()
@property (weak, nonatomic) OApaintView *paintView;
@property (weak, nonatomic) UIView *bottomView;
/**
 *  底部按钮
 */
@property (weak, nonatomic) UIButton *redBtn;
@property (weak, nonatomic) UIButton *blueBtn;
@property (weak, nonatomic) UIButton *cyanBtn;
@property (weak, nonatomic) UISlider *slider;
/**
 *  顶部
 */
@property (weak, nonatomic) UIToolbar *toolbar;
@property (weak, nonatomic) UIBarButtonItem *clearScreen;
@property (weak, nonatomic) UIBarButtonItem *back;
@property (weak, nonatomic) UIBarButtonItem *eraser;
@property (weak, nonatomic) UIBarButtonItem *save;
/**
 *  弹簧
 */
@property (weak, nonatomic) UIBarButtonItem *space;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self stupUI];
    [self settingFrame];
    
    // MARK: - 设置初始线宽
    [self sliderValueChanged:self.slider];
    
    // MARK: - 设置初始颜色
    [self colorBtnClick:self.redBtn];
    // MARK: - 3 给block赋值
    self.paintView.paintBlock = ^(OApaintView *paintV, UIImage *snapImg){
        
        // 将图片存储到相册
        UIImageWriteToSavedPhotosAlbum(snapImg, nil, nil, nil);
        [self image:snapImg didFinishSavingWithError:nil contextInfo:nil];
        
    };

}

#pragma mark - 添加控件
- (void)stupUI{
    //画板view
    OApaintView *paintView = [[OApaintView alloc] init];
    paintView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:paintView];
    self.paintView = paintView;
    
    //顶部toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    UIBarButtonItem *clearScreen = [[UIBarButtonItem alloc] initWithTitle:@"清屏" style:UIBarButtonItemStylePlain target:self action:@selector(clearScreen:)];
    UIBarButtonItem *back= [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    UIBarButtonItem *eraser = [[UIBarButtonItem alloc] initWithTitle:@"橡皮擦" style:UIBarButtonItemStylePlain target:self action:@selector(eraser:)];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *item = [NSArray arrayWithObjects:clearScreen,back,eraser,space,save,nil];
    
    [toolbar setItems:item animated:YES];
    
    //底部view
    
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    UISlider *slider = [[UISlider alloc] init];
    [bottomView addSubview:slider];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    slider.minimumValue = 1;
    slider.maximumValue = 50;
    self.slider = slider;
    
    
    UIButton *redBtn = [[UIButton alloc] init];
    redBtn.backgroundColor = [UIColor redColor];
    [bottomView addSubview:redBtn];
    [redBtn addTarget:self action:@selector(colorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.redBtn = redBtn;
    
    UIButton *blueBtn = [[UIButton alloc] init];
    blueBtn.backgroundColor = [UIColor blueColor];
    [bottomView addSubview:blueBtn];
    [blueBtn addTarget:self action:@selector(colorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.blueBtn = blueBtn;
    
    UIButton *cyanBtn = [[UIButton alloc] init];
    cyanBtn.backgroundColor = [UIColor cyanColor];
    [bottomView addSubview:cyanBtn];
    [cyanBtn addTarget:self action:@selector(colorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cyanBtn = cyanBtn;
    
   
    
}

#pragma mark - 自动布局
- (void)settingFrame{
    //顶部
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self.view);
    }];
    
    //画板view
    [self.paintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toolbar.mas_bottom);
        make.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
        
    }];
    
    //底部view
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.paintView.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        make.height.mas_equalTo(60);
    }];
    
    
    //底部view的按钮
    //slider
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.bottomView);
    }];
    
    //redBtn
    [self.redBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.bottomView.mas_leading).offset(20);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-5);
        make.height.mas_equalTo(20);
        
    }];
    [self.blueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.redBtn.mas_trailing).offset(20);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-5);
        make.height.width.mas_equalTo(self.redBtn);
    }];
    
    [self.cyanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.blueBtn.mas_trailing).offset(20);
        make.trailing.mas_equalTo(self.bottomView.mas_trailing).offset(-20);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-5);
        make.height.width.mas_equalTo(self.redBtn);
    }];
}





#pragma mark - 其他功能事件
/**
 *  清屏
 */
- (void)clearScreen:(id)sender {
    
    [self.paintView clearAllLines];
    
}
/**
 *  回退
 */
- (void)back:(id)sender {
    
    [self.paintView back];
}

/**
 *  橡皮擦
 */
- (void)eraser:(id)sender {
    
    
    // 直接将颜色设置为画板的背景色
    // 再次画线,显示的效果与画板的背景一致
    self.paintView.lineC = self.paintView.backgroundColor;
}
/**
 *  保存
 */
- (void)save:(id)sender {
    
    
    // MARK: - 通过代理获取图片
    [self.paintView snapPaintView];
    
}
#pragma mark - 保存到相册成功后会调用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    // 1.弹窗
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *qued = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVc addAction:qued];
    
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

#pragma mark - 监听颜色按钮的点击
- (void)colorBtnClick:(UIButton *)sender {
    
    // 1.获取按钮的背景色
    UIColor *aimColor = sender.backgroundColor;
    
    // 2.传给自定义画板
    self.paintView.lineC = aimColor;
    
}

#pragma mark - 监听slider的值改变事件
- (void)sliderValueChanged:(UISlider *)sender {
    
    // 1.获取滑块的值
    float value = sender.value;
    
    // 2.传给自定义画板
    self.paintView.lineW = value;
}







#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}




@end
