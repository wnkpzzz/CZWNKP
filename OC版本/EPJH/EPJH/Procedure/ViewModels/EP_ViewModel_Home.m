//
//  EP_ViewModel_Home.m
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_ViewModel_Home.h"
#import "EP_Model_CaseSqe_MainList.h"

@implementation EP_ViewModel_Home

/** 案例广场 */
- (void)requestCaseSquareWithBrand:(NSString *)brandId
                           Project:(NSString *)proId
                              Page:(NSInteger )pageInt
                        Completion:(CallbackAllCompletion)handler{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"partyId"] = KUID;
    params[@"brand"] = brandId;
    params[@"project"] = proId;
    params[@"pageNumber"] = [NSString stringWithFormat:@"%ld",pageInt];
    params[@"pageSize"] = @"10";

    [KAppNetRequestWithShowLog(YES) AF_GetNetWorkWithHeaderUrlStr:URL_case_list Parameter:params completion:^(NSDictionary *dic, NSError *error) {
        
        if (error) { handler(NO,@"",kNetErrorStr); }

        else {

            if ([dic[@"statusCode"] isEqualToString:@"200"]) {

            NSArray * listArr = [NSArray modelArrayWithClass:[EP_Model_CaseSqe_MainList class] json:dic[@"caseViews"]];

            handler(YES,listArr,@"");

            }else{ handler(NO,@"",dic[@"msg"]);}

        }
       
        
    }];

}

@end
