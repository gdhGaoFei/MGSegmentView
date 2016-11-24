//
//  MGSegmentModel.m
//  MGSegmentView
//
//  Created by 高得华 on 16/11/24.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import "MGSegmentModel.h"

@interface MGSegmentModel ()

@end

@implementation MGSegmentModel

/**
 创建Segment的Model
 
 @param title 标题
 @param norImg 未选中的图片
 @param selImg 选中的图片
 @return MGSegmentModel
 */
+ (instancetype) CreateSegmentTitle:(NSString *)title
                             norImg:(NSString *)norImg
                             selImg:(NSString *)selImg{
    MGSegmentModel * model = [[MGSegmentModel alloc] init];
    
    model.selectImage = selImg;
    model.title       = title;
    model.norImage    = norImg;
    
    return model;
}

@end
