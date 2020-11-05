//
//  EP_Model_CaseSqe_MainList.h
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EP_Model_CaseSqe_MainList : NSObject

@property (nonatomic,strong) NSArray<EP_Model_CaseSqe_MainList *> * datas;

@property (nonatomic, strong) NSString * id;

@property (nonatomic, strong) NSString * brand;
@property (nonatomic, strong) NSString * brandName;
@property (nonatomic, assign) NSInteger caseDate;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSArray * imageList;
@property (nonatomic, assign) NSInteger isCollection;
@property (nonatomic, assign) NSInteger isTop;
@property (nonatomic, strong) NSString * project;
@property (nonatomic, strong) NSString * projectName;

@property (nonatomic, strong) NSString * uploadHeadImage;
@property (nonatomic, strong) NSString * uploadName;

@end

NS_ASSUME_NONNULL_END

//EP_Model_CaseSqe_MainList
//EP_Model_CaseSqe_DetailList
