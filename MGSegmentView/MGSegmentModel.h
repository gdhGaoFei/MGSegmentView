//
//  MGSegmentModel.h
//  MGSegmentView
//
//  Created by 高得华 on 16/11/24.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGSegmentModel : NSObject

/**
 创建Segment的Model

 @param title 标题
 @param norImg 未选中的图片
 @param selImg 选中的图片
 @return MGSegmentModel
 */
+ (instancetype) CreateSegmentTitle:(NSString *)title
                             norImg:(NSString *)norImg
                             selImg:(NSString *)selImg;

/**
 标题
 */
@property (nonatomic, copy) NSString * title;

/**
 未选中的图片
 */
@property (nonatomic, copy) NSString * norImage;

/**
 选中时的图片
 */
@property (nonatomic, copy) NSString * selectImage;

@end
