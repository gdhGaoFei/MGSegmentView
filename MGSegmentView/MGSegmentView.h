//
//  MGSegmentView.h
//  MGSegmentView
//
//  Created by 高得华 on 16/11/24.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSegmentModel.h"

@class MGSegmentView;

@protocol MGSegmentViewDelegate <NSObject>

@optional
- (void)segmentView:(MGSegmentView *)segmentView didSelectedSegmentAtIndex:(NSInteger)index lastSelectedSegmentAtIndex:(NSInteger)lastIndex;

@end


@interface MGSegmentView : UIView


/**
 创建MGSegmentView

 @param titles 数据源数组
 @param frame  视图的frame
 @return MGSegmentView对象
 */
+ (instancetype)CreateSegmentTitles:(NSMutableArray <MGSegmentModel *> *)titles
                              frame:(CGRect)frame;


/**
 创建MGSegmentView
 
 @param frame  视图的frame
 @param titles 数据源数组
 @return MGSegmentView对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSMutableArray <MGSegmentModel *> *)titles;


/**
 代理
 */
@property (nonatomic, assign) id <MGSegmentViewDelegate> delegate;

/**
 数据源数组
 */
@property (nonatomic, strong) NSMutableArray <MGSegmentModel *>* titles;

/**
 字体大小
 */
@property (nonatomic, assign) CGFloat  buttonFont;

/**
 未选中的字体颜色
 */
@property (nonatomic, strong) UIColor * normalTitleColor;

/**
 选中的字体颜色
 */
@property (nonatomic, strong) UIColor * selectTitleColor;

/**
 默认选中项 默认从0开始
 */
@property (nonatomic, assign) NSInteger defaultSeleted;

/**
 每个Button的高度 默认是视图的高度  就是视图的高度
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 block 返回当前选中的按钮及上一次点击的按钮
 */
@property (nonatomic, copy) void(^ReturnClickSegmetAtIndex)(NSInteger index, NSInteger lastIndex);

/**
 点击同一个按钮是否需要返回点击响应事件 默认NO
 */
@property (nonatomic, assign) BOOL isClickIndexReturn;

@end
