//
//  MGSegmentView.m
//  MGSegmentView
//
//  Created by 高得华 on 16/11/24.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import "MGSegmentView.h"

@interface MGSegmentView ()

/**
 上一次点击的btn
 */
@property (nonatomic, strong) UIButton * lastButton;
@property (nonatomic, strong) NSMutableArray <UIButton *> * buttonArray;

@end

@implementation MGSegmentView

/**
 创建MGSegmentView
 
 @param titles 数据源数组
 @return MGSegmentView对象
 */
+ (instancetype)CreateSegmentTitles:(NSMutableArray <MGSegmentModel *> *)titles
                              frame:(CGRect)frame {
    MGSegmentView * view = [[MGSegmentView alloc] initWithFrame:frame];
    
    view.titles = titles;
    
    return view;
}

/**
 创建MGSegmentView
 
 @param frame  视图的frame
 @param titles 数据源数组
 @return MGSegmentView对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSMutableArray <MGSegmentModel *> *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        //设置页面布局
        [self loadCreateViewLayout];
    }
    return self;
}
-(void)awakeFromNib {
    [super awakeFromNib];
    //设置页面布局
    [self loadCreateViewLayout];
}

/**!
 * 设置页面布局
 */
- (void)loadCreateViewLayout {
    self.normalTitleColor = [UIColor blackColor];//未选中的字体颜色
    self.selectTitleColor = [UIColor whiteColor];//选中的字体颜色
    self.defaultSeleted   = 0;//默认选中项
    self.buttonFont       = 18;//默认字体大小
    self.itemHeight       = CGRectGetHeight(self.frame);//每个按钮的高度
    self.isClickIndexReturn = NO;
}

/**
 button的点击响应事件

 @param sender button对象
 */
- (void)buttonClickAction:(UIButton *)sender {
    if (sender != self.lastButton) {
        self.lastButton.selected = NO;
        sender.selected = YES;
        
        //设置属性
//        self.lastButton.titleLabel.font = [UIFont systemFontOfSize:self.buttonFont];
//        sender.titleLabel.font = [UIFont systemFontOfSize:self.buttonFont];
        [self.lastButton setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        [sender setTitleColor:self.selectTitleColor forState:UIControlStateHighlighted];
        [sender setTitleColor:self.selectTitleColor forState:UIControlStateSelected];
        
        if ([self.delegate respondsToSelector:@selector(segmentView:didSelectedSegmentAtIndex:lastSelectedSegmentAtIndex:)]) {
            [self.delegate segmentView:self didSelectedSegmentAtIndex:sender.tag-100 lastSelectedSegmentAtIndex:self.lastButton.tag-100];
        }
        if (self.ReturnClickSegmetAtIndex) {
            self.ReturnClickSegmetAtIndex(sender.tag-100, self.lastButton.tag-100);
        }
        
    }else {
        if (self.isClickIndexReturn) {
            if ([self.delegate respondsToSelector:@selector(segmentView:didSelectedSegmentAtIndex:lastSelectedSegmentAtIndex:)]) {
                [self.delegate segmentView:self didSelectedSegmentAtIndex:sender.tag-100 lastSelectedSegmentAtIndex:self.lastButton.tag-100];
            }
            if (self.ReturnClickSegmetAtIndex) {
                self.ReturnClickSegmetAtIndex(sender.tag-100, self.lastButton.tag-100);
            }
        }
    }
    
    self.lastButton = sender;
}


/**
 创建button
 */
- (void) loadCreateButton {
    // 1.移除所有的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 2.添加新的按钮
    NSInteger count = self.titles.count;
    CGFloat btnWidth = CGRectGetWidth(self.frame) / count;
    
    for (NSInteger i = 0; i < count; i++) {
        MGSegmentModel * model = self.titles[i];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 100;
        // 设置按钮的frame
        button.frame = CGRectMake(i * btnWidth, 0, btnWidth, self.itemHeight);
        
        //设置背景图片
        [button setBackgroundImage:[self ReturnSizeImage:model.norImage] forState:UIControlStateNormal];
        [button setBackgroundImage:[self ReturnSizeImage:model.selectImage] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[self ReturnSizeImage:model.selectImage] forState:UIControlStateSelected];
        
        //设置文字
        button.titleLabel.font = [UIFont systemFontOfSize:self.buttonFont];
        [button setTitle:model.title forState:UIControlStateNormal];
        [button setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectTitleColor forState:UIControlStateHighlighted];
        [button setTitleColor:self.selectTitleColor forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //添加方法
        if (self.defaultSeleted >= count) {
            if (i == 0) {
                [self buttonClickAction:button];
            }
        }else{
            if (self.defaultSeleted == i) {
                [self buttonClickAction:button];
            }
        }
        
        [self.buttonArray addObject:button];
        //添加到视图上
        [self addSubview:button];
    }
    self.bounds = CGRectMake(0, 0, count * btnWidth, self.itemHeight);
}


#pragma mark ======== // 重写Set方法 \\ ================
//数据源数组
-(void)setTitles:(NSMutableArray<MGSegmentModel *> *)titles {
    _titles = titles;
    
    //创建button
    [self loadCreateButton];
}
//字体大小
-(void)setButtonFont:(CGFloat)buttonFont {
    _buttonFont = buttonFont;
    if (self.buttonArray > 0) {
        //改变字体大小 ===> 两种方法
        //第一种  重新创建
//        [self loadCreateButton];
        
        //第二种 使用数组
        for (UIButton * button in self.buttonArray) {
            button.titleLabel.font = [UIFont systemFontOfSize:buttonFont];
        }
    }
}
//默认选中项
-(void)setDefaultSeleted:(NSInteger)defaultSeleted {
    _defaultSeleted = defaultSeleted;
    if (defaultSeleted >=0 && defaultSeleted <= self.titles.count - 1) {
        UIButton *btn = (UIButton *)[self viewWithTag:100 + defaultSeleted];
        [self buttonClickAction:btn];
    }}
//默认下字体的颜色
-(void)setNormalTitleColor:(UIColor *)normalTitleColor {
    _normalTitleColor = normalTitleColor;
    [self.lastButton setTitleColor:normalTitleColor forState:UIControlStateNormal];
}
//选中的字体颜色
-(void)setSelectTitleColor:(UIColor *)selectTitleColor {
    _selectTitleColor = selectTitleColor;
    [self.lastButton setTitleColor:selectTitleColor forState:UIControlStateHighlighted];
    [self.lastButton setTitleColor:selectTitleColor forState:UIControlStateSelected];
}
//每个按钮的高度
-(void)setItemHeight:(CGFloat)itemHeight {
    _itemHeight = itemHeight;
    if (self.titles > 0) {
        [self loadCreateButton];
    }
}
//点击同一个按钮时 是否返回点击响应事件
-(void)setIsClickIndexReturn:(BOOL)isClickIndexReturn {
    _isClickIndexReturn = isClickIndexReturn;
}

#pragma mark ======= // 懒加载 \\ ==========
-(NSMutableArray<UIButton *> *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

#pragma mark ======= // 辅助方法 \\ ===============
-(UIImage *)ReturnSizeImage:(NSString *)imgName {
    return [self resizeImage:[UIImage imageNamed:imgName]];
}
- (UIImage *)resizeImage:(UIImage *)image
{
    CGFloat leftCap = image.size.width * 0.5f;
    CGFloat topCap = image.size.height * 0.5f;
    return [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}



@end
