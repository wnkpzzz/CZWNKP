//
//  EPTypeListClassifyModel.h
//  EPJH
//
//  Created by Hans on 2020/8/26.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPTypeListClassifyModel : NSObject

@property (nonatomic,copy) NSString * imageUrl;

@property (nonatomic,copy) NSString * imageChooseUrl;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * parentId;

@property (nonatomic,copy) NSString * tag;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,strong) NSArray<EPTypeListClassifyModel *> * cateViews;

@end

NS_ASSUME_NONNULL_END
