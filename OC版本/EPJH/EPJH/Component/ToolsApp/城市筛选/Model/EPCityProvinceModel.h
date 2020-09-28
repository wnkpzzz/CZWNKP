//
//  EPCityProvinceModel.h
//  EPJH
//
//  Created by Hans on 2020/9/28.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPCityProvinceModel : NSObject

@property (nonatomic,copy)NSString * id;

@property (nonatomic,copy)NSString * key;

@property (nonatomic,copy)NSString * depth;

@property (nonatomic,copy)NSString * name;

@property (nonatomic,copy)NSString * parentId;

@property (nonatomic,copy)NSString * url;

@property (nonatomic,copy)NSString * imageUrl;

@end

NS_ASSUME_NONNULL_END
