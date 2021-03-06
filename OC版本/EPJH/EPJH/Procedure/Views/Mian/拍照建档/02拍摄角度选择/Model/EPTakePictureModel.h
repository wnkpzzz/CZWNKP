//
//  EPTakePictureModel.h
//  EPJH
//
//  Created by Hans on 2020/8/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPTakePictureModel : NSObject

@property (nonatomic, copy)   NSString *title;                      // 标题
@property (nonatomic, assign) NSInteger index;                      // 位置索引
@property (nonatomic, assign) NSInteger partsIndex;                 // 部位索引
@property (nonatomic, strong) UIImage  *_Nullable cameraImage;      // 拍摄的图片
@property (nonatomic, strong) UIImage  *_Nullable defaultImage;     // 对比图片(为空时，用默认对比图)
@property (nonatomic,copy)    NSString * cameraImgStr;              // 拍摄的照片预备存储的名字

@end

NS_ASSUME_NONNULL_END
