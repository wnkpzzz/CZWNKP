//
//  EPProjectHeadFileHandler.h
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#ifndef EPProjectHeadFileHandler_h
#define EPProjectHeadFileHandler_h


// 建档流程Model
#import "EPImageModel.h"
#import "EPProjectModel.h"
#import "EPUserInfoModel.h"


// 00新建档案
#import "EPNewProjectViewCtl.h"

// 01选择用户
#import "EPUserSelectViewCtl.h"


// 02拍摄角度选择
#import "EPAngleSelectViewCtl.h"     // 拍摄角度选择
#import "EPAngleHeaderCell.h"
#import "EPAngleSelectCell.h"
#import "EPAngleBottomCell.h"
#import "EPAngleSelectColCell.h"
#import "EPBottomImgSelectColCell.h"
 
// 02弹出拍照
#import "EPCasePhotographyViewCtl.h" // 弹出拍照
#import "EPTakePictureModel.h"       // 图片拍照流程中的数据Model
#import "CZAlbumScrollView.h"        // 同屏放大缩小相关

// 03项目选择
#import "EPProjectSelectViewCtl.h"   // 项目选择
#import "EPTypeMaterialListView.h"   // 弹出材料

#import "EPBodyPartTableViewCell.h"
#import "EPSurgeryTypeTableViewCell.h"
#import "EPSurgeryDetailTableViewCell.h"

#import "EPCameraBodyPartCollectionViewCell.h"
#import "EPSurgeryTypeCollectionViewCell.h"

#import "EPTypeListClassifyModel.h"




#endif /* EPProjectHeadFileHandler_h */
