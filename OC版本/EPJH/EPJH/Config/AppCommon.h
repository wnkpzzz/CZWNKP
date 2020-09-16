//
//  AppCommon.h
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#ifndef AppCommon_h
#define AppCommon_h

#define NSUSERDEFAULTS          [NSUserDefaults standardUserDefaults]
#define KUID                    [NSUSERDEFAULTS objectForKey:kUserID]
#define KSID                    [NSUSERDEFAULTS objectForKey:kUserSID]

#define kUserID                 @"kUserID"
#define kUserSID                @"kUserSID"
#define kPhoneNum               @"kPhoneNum"
#define kUserImage              @"kUserImage"

#define kTipsFlag               @"kTipsFlag"            // 拍摄角度选择页面的提示。
#define kCheckInstallFlag       @"kCheckInstallFlag"    // 检测是否是初次安装弹出隐私政策

 

#endif /* AppCommon_h */
