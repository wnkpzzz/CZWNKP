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

 

#define kTimeArray   @[@"术前",@"术后",@"复诊"]

// 时间节点ID
#define kShuQianID   @"100000626000002"
#define kShuHouID    @"100000753000002"
#define kFuZhenID    @"100000754000002"

// 部位节点ID
#define kMianBuID    @"100000626000008" //面部
#define kBiBuID      @"100000626000009" //鼻部
//#define kYanBuID     @"100000626000010" //眼部
//#define kErBuID      @"100000626000011" //耳部
//#define kKouChunID   @"100000626000012" //口唇
#define kBiaoQingID  @"100000626000013" //表情

#define kShenTiID    @"100000626000029" //身体
#define kXiongBuID   @"100000626000030" //胸部
//#define kYaoFuID     @"100000626000031" //腰腹
//#define kDaTuiID     @"100000626000032" //大腿
//#define kXiaoTuiID   @"100000626000033" //小腿
//#define kShouBiID    @"100000626000034" //手臂
//#define kQianBiID    @"100000626000035" //前臂
//#define kShouZhangID @"100000626000036" //手掌

#define kZiDingYiID  @"100000888000002" //自定义

// 部位节点ID数组
#define kPartsIDArr @[kMianBuID,kBiBuID,kBiaoQingID,kShenTiID,kXiongBuID,kZiDingYiID]
// 部位节点名数组
#define kPartsNameArr @[@"面部",@"鼻部",@"表情",@"身体",@"胸部",@"自定义"]
// 部位节点默认位数量数组
#define kPartsCountArr @[@"6",@"10",@"9",@"6",@"5",@"6"]

// 六部位照片位置节点
#define kMianBuIDArray        @[@"100000790000001",@"100000790000002",@"100000790000003",@"100000790000004",@"100000790000005",@"100000790000006",@"100000790000007",@"100000790000008",@"100000790000009",@"100000790000010",@"100000790000011",@"100000790000012"] //面部
#define kBiBuIDArray        @[@"100000791000001",@"100000791000002",@"100000791000003",@"100000791000004",@"100000791000005",@"100000791000006",@"100000791000007",@"100000791000008",@"100000791000009",@"100000791000010",@"100000791000011",@"100000791000012"] //鼻部
//#define kYanBuIDArray        @[@"100000792000001",@"100000792000002",@"100000792000003",@"100000792000004",@"100000792000005",@"100000792000006",@"100000792000007",@"100000792000008",@"100000792000009",@"100000792000010",@"100000792000011",@"100000792000012"] //眼部
//#define kErBuIDArray        @[@"100000793000001",@"100000793000002",@"100000793000003",@"100000793000004",@"100000793000005",@"100000793000006",@"100000793000007",@"100000793000008",@"100000793000009",@"100000793000010",@"100000793000011",@"100000793000012"] //耳部
//#define kKouChunIDArray        @[@"100000794000001",@"100000794000002",@"100000794000003",@"100000794000004",@"100000794000005",@"100000794000006",@"100000794000007",@"100000794000008",@"100000794000009",@"100000794000010",@"100000794000011",@"100000794000012"] //口唇
#define kBiaoQingIDArray        @[@"100000795000001",@"100000795000002",@"100000795000003",@"100000795000004",@"100000795000005",@"100000795000006",@"100000795000007",@"100000795000008",@"100000795000009",@"100000795000010",@"100000795000011",@"100000795000012"] //表情

#define kShenTiIDArray        @[@"100000895002369",@"100000895002370",@"100000895002371",@"100000895002372",@"100000895002373",@"100000895002374",@"100000895002375",@"100000895002376",@"100000895002377",@"100000895002378",@"100000895002379",@"100000895002380"] //身体
#define kXiongBuIIDArray        @[@"100000896002369",@"100000896002370",@"100000896002371",@"100000896002372",@"100000896002373",@"100000896002374",@"100000896002375",@"100000896002376",@"100000896002377",@"100000896002378",@"100000896002379",@"100000896002380"] //胸部
//#define kYaoFuIDArray        @[@"100000897002369",@"100000897002370",@"100000897002371",@"100000897002372",@"100000897002373",@"100000897002374",@"100000897002375",@"100000897002376",@"100000897002377",@"100000897002378",@"100000897002379",@"100000897002380"] //腰腹
//#define kDaTuiIDArray        @[@"100000898002369",@"100000898002370",@"100000898002371",@"100000898002372",@"100000898002373",@"100000898002374",@"100000898002375",@"100000898002376",@"100000898002377",@"100000898002378",@"100000898002379",@"100000898002380"] //大腿
//#define kXiaoTuiIDArray        @[@"100000899002369",@"100000899002370",@"100000899002371",@"100000899002372",@"100000899002373",@"100000899002374",@"100000899002375",@"100000899002376",@"100000899002377",@"100000899002378",@"100000899002379",@"100000899002380"] //小腿
//#define kShouBiIDArray        @[@"100000900002369",@"100000900002370",@"100000900002371",@"100000900002372",@"100000900002373",@"100000900002374",@"100000900002375",@"100000900002376",@"100000900002377",@"100000900002378",@"100000900002379",@"100000900002380"] //手臂
//#define kQianBiIDArray        @[@"100000901002369",@"100000901002370",@"100000901002371",@"100000901002372",@"100000901002373",@"100000901002374",@"100000901002375",@"100000901002376",@"100000901002377",@"100000901002378",@"100000901002379",@"100000901002380"] //前臂
//#define kShouZhangIDArray        @[@"100000902002369",@"100000902002370",@"100000902002371",@"100000902002372",@"100000902002373",@"100000902002374",@"100000902002375",@"100000902002376",@"100000902002377",@"100000902002378",@"100000902002379",@"100000902002380"] //手掌

#define kZiDingYiIDArray         @[@"100000887000663",@"100000887000664",@"100000887000665",@"100000887000666",@"100000887000667",@"100000887000668",@"100000887000669",@"100000887000670",@"100000887000671",@"100000887000672",@"100000887000673",@"100000887000674"] //自定义

// 拍摄部位图片位置ID数组
#define kPartsImgsPoIDArr @[kMianBuIDArray,kBiBuIDArray,kBiaoQingIDArray,kShenTiIDArray,kXiongBuIIDArray,kZiDingYiIDArray]

// 每个位置默认名字
#define kDefaultMianBuTitleArray    @[@"正面",@"左斜45°",@"左侧90°",@"右斜45°",@"右侧90°",@"仰角",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义"]
#define kDefaultBiBuTitleArray    @[@"正面",@"左斜45°",@"左侧90°",@"右斜45°",@"右侧90°",@"仰角",@"上仰45°",@"上仰90°",@"下俯45°",@"下俯90°",@"自定义",@"自定义"]
#define kDefaultBiaoQingTitleArray    @[@"微笑",@"挑眉",@"大笑",@"嘟嘴",@"正面",@"左斜45°",@"左侧90°",@"右斜45°",@"右侧90°",@"自定义",@"自定义",@"自定义"]
#define kDefaultShenTiTitleArray    @[@"正面",@"左斜45°",@"左侧90°",@"右斜45°",@"右侧90°",@"后背",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义"]
#define kDefaultXiongBuTitleArray    @[@"正面",@"左斜45°",@"左侧90°",@"右斜45°",@"右侧90°",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义"]
#define kDefaultZiDingYiTitleArray    @[@"角度1",@"角度2",@"角度3",@"角度4",@"角度5",@"角度6",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义"]

// 拍摄部位图片位置名称数组
#define kPartsImgsPoNameArr @[kDefaultMianBuTitleArray,kDefaultBiBuTitleArray,kDefaultBiaoQingTitleArray,kDefaultShenTiTitleArray,kDefaultXiongBuTitleArray,kDefaultZiDingYiTitleArray]

// 选择角度拍摄默认图
#define kDefaultMianBuArray     @[@"Mark_Face_01.jpg",@"Mark_Face_02.jpg",@"Mark_Face_03.jpg",@"Mark_Face_04.jpg",@"Mark_Face_05.jpg",@"Mark_Face_06.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg"]
#define kDefaultBiBuArray     @[@"Mark_Nose_01.jpg",@"Mark_Nose_02.jpg",@"Mark_Nose_03.jpg",@"Mark_Nose_04.jpg",@"Mark_Nose_05.jpg",@"Mark_Nose_06.jpg",@"Mark_Nose_07.jpg",@"Mark_Nose_08.jpg",@"Mark_Nose_09.jpg",@"Mark_Nose_10.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg"]
#define kDefaultBiaoQingArray    @[@"Mark_Expression_01.jpg",@"Mark_Expression_02.jpg",@"Mark_Expression_03.jpg",@"Mark_Expression_04.jpg",@"Mark_Face_01.jpg",@"Mark_Face_02.jpg",@"Mark_Face_03.jpg",@"Mark_Face_04.jpg",@"Mark_Face_05.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg"]
#define kDefaultShenTiArray     @[@"Mark_Section_01.jpg",@"Mark_Section_02.jpg",@"Mark_Section_03.jpg",@"Mark_Section_04.jpg",@"Mark_Section_05.jpg",@"Mark_Section_06.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg"]
#define kDefaultXiongBuArray    @[@"Mark_Chest_01.jpg",@"Mark_Chest_02.jpg",@"Mark_Chest_03.jpg",@"Mark_Chest_04.jpg",@"Mark_Chest_05.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg"]
#define kDefaultZiDingYiArray    @[@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Custom.jpg"]

// 选择角度拍摄默认图数组
#define kDefaultTempImageArray @[kDefaultMianBuArray,kDefaultBiBuArray,kDefaultBiaoQingArray,kDefaultShenTiArray,kDefaultXiongBuArray,kDefaultZiDingYiArray]

// 拍摄参照图
#define kCameraMianBuArray     @[@"Mark_Camera_Face_01.jpg",@"Mark_Camera_Face_02.jpg",@"Mark_Camera_Face_03.jpg",@"Mark_Camera_Face_04.jpg",@"Mark_Camera_Face_05.jpg",@"Mark_Camera_Face_06.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg"]
#define kCameraBiBuArray     @[@"Mark_Camera_Nose_01.jpg",@"Mark_Camera_Nose_02.jpg",@"Mark_Camera_Nose_03.jpg",@"Mark_Camera_Nose_04.jpg",@"Mark_Camera_Nose_05.jpg",@"Mark_Camera_Nose_06.jpg",@"Mark_Camera_Nose_07.jpg",@"Mark_Camera_Nose_08.jpg",@"Mark_Camera_Nose_09.jpg",@"Mark_Camera_Nose_10.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg"]
#define kCameraBiaoQingArray    @[@"Mark_Camera_Expression_01.jpg",@"Mark_Camera_Expression_02.jpg",@"Mark_Camera_Expression_03.jpg",@"Mark_Camera_Expression_04.jpg",@"Mark_Camera_Face_01.jpg",@"Mark_Camera_Face_02.jpg",@"Mark_Camera_Face_03.jpg",@"Mark_Camera_Face_04.jpg",@"Mark_Camera_Face_05.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg"]
#define kCameraShenTiArray     @[@"Mark_Camera_Section_01.jpg",@"Mark_Camera_Section_02.jpg",@"Mark_Camera_Section_03.jpg",@"Mark_Camera_Section_04.jpg",@"Mark_Camera_Section_05.jpg",@"Mark_Camera_Section_06.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg"]
#define kCameraXiongBuArray    @[@"Mark_Camera_Chest_01.jpg",@"Mark_Camera_Chest_02.jpg",@"Mark_Camera_Chest_03.jpg",@"Mark_Camera_Chest_04.jpg",@"Mark_Camera_Chest_05.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg"]
#define kCameraZiDingYiArray    @[@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg",@"Mark_Camera_Custom.jpg"]

// 拍摄参照图组
#define kCameraTempImageArray @[kCameraMianBuArray,kCameraBiBuArray,kCameraBiaoQingArray,kCameraShenTiArray,kCameraXiongBuArray,kCameraZiDingYiArray]

// 拍摄参照线图
#define kCameraFrameMianBuArray     @[@"Mark_Camera_Frame_Face_01.jpg",@"Mark_Camera_Frame_Face_02.jpg",@"Mark_Camera_Frame_Face_03.jpg",@"Mark_Camera_Frame_Face_04.jpg",@"Mark_Camera_Frame_Face_05.jpg",@"Mark_Camera_Frame_Face_06.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg"]
#define kCameraFrameBiBuArray     @[@"Mark_Camera_Frame_Nose_01.jpg",@"Mark_Camera_Frame_Nose_02.jpg",@"Mark_Camera_Frame_Nose_03.jpg",@"Mark_Camera_Frame_Nose_04.jpg",@"Mark_Camera_Frame_Nose_05.jpg",@"Mark_Camera_Frame_Nose_06.jpg",@"Mark_Camera_Frame_Nose_07.jpg",@"Mark_Camera_Frame_Nose_08.jpg",@"Mark_Camera_Frame_Nose_09.jpg",@"Mark_Camera_Frame_Nose_10.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg"]
#define kCameraFrameBiaoQingArray    @[@"Mark_Camera_Frame_Expression_01.jpg",@"Mark_Camera_Frame_Expression_02.jpg",@"Mark_Camera_Frame_Expression_03.jpg",@"Mark_Camera_Frame_Expression_04.jpg",@"Mark_Camera_Frame_Face_01.jpg",@"Mark_Camera_Frame_Face_02.jpg",@"Mark_Camera_Frame_Face_03.jpg",@"Mark_Camera_Frame_Face_04.jpg",@"Mark_Camera_Frame_Face_05.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg"]
#define kCameraFrameShenTiArray     @[@"Mark_Camera_Frame_Section_01.jpg",@"Mark_Camera_Frame_Section_02.jpg",@"Mark_Camera_Frame_Section_03.jpg",@"Mark_Camera_Frame_Section_04.jpg",@"Mark_Camera_Frame_Section_05.jpg",@"Mark_Camera_Frame_Section_06.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg"]
#define kCameraFrameXiongBuArray    @[@"Mark_Camera_Frame_Chest_01.jpg",@"Mark_Camera_Frame_Chest_02.jpg",@"Mark_Camera_Frame_Chest_03.jpg",@"Mark_Camera_Frame_Chest_04.jpg",@"Mark_Camera_Frame_Chest_05.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg"]
#define kCameraFrameZiDingYiArray    @[@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg",@"Mark_Camera_Frame_Custom.jpg"]


// 拍摄参照线图
#define kCameraFrameTempImageArray @[kCameraFrameMianBuArray,kCameraFrameBiBuArray,kCameraFrameBiaoQingArray,kCameraFrameShenTiArray,kCameraFrameXiongBuArray,kCameraFrameZiDingYiArray]

// 拍摄参照图X
#define kCameraMianBuArrayX     @[@"Mark_X_Camera_Face_01.jpg",@"Mark_X_Camera_Face_02.jpg",@"Mark_X_Camera_Face_03.jpg",@"Mark_X_Camera_Face_04.jpg",@"Mark_X_Camera_Face_05.jpg",@"Mark_X_Camera_Face_06.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg"]
#define kCameraBiBuArrayX     @[@"Mark_X_Camera_Nose_01.jpg",@"Mark_X_Camera_Nose_02.jpg",@"Mark_X_Camera_Nose_03.jpg",@"Mark_X_Camera_Nose_04.jpg",@"Mark_X_Camera_Nose_05.jpg",@"Mark_X_Camera_Nose_06.jpg",@"Mark_X_Camera_Nose_07.jpg",@"Mark_X_Camera_Nose_08.jpg",@"Mark_X_Camera_Nose_09.jpg",@"Mark_X_Camera_Nose_10.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg"]
#define kCameraBiaoQingArrayX    @[@"Mark_X_Camera_Expression_01.jpg",@"Mark_X_Camera_Expression_02.jpg",@"Mark_X_Camera_Expression_03.jpg",@"Mark_X_Camera_Expression_04.jpg",@"Mark_X_Camera_Face_01.jpg",@"Mark_X_Camera_Face_02.jpg",@"Mark_X_Camera_Face_03.jpg",@"Mark_X_Camera_Face_04.jpg",@"Mark_X_Camera_Face_05.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg"]
#define kCameraShenTiArrayX     @[@"Mark_X_Camera_Section_01.jpg",@"Mark_X_Camera_Section_02.jpg",@"Mark_X_Camera_Section_03.jpg",@"Mark_X_Camera_Section_04.jpg",@"Mark_X_Camera_Section_05.jpg",@"Mark_X_Camera_Section_06.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg"]
#define kCameraXiongBuArrayX    @[@"Mark_X_Camera_Chest_01.jpg",@"Mark_X_Camera_Chest_02.jpg",@"Mark_X_Camera_Chest_03.jpg",@"Mark_X_Camera_Chest_04.jpg",@"Mark_X_Camera_Chest_05.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg"]
#define kCameraZiDingYiArrayX    @[@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg",@"Mark_X_Camera_Custom.jpg"]

// 拍摄参照图组X
#define kCameraTempImageArrayX @[kCameraMianBuArrayX,kCameraBiBuArrayX,kCameraBiaoQingArrayX,kCameraShenTiArrayX,kCameraXiongBuArrayX,kCameraZiDingYiArrayX]

// 拍摄参照线图X
#define kCameraFrameMianBuArrayX     @[@"Mark_X_Camera_Frame_Face_01.jpg",@"Mark_X_Camera_Frame_Face_02.jpg",@"Mark_X_Camera_Frame_Face_03.jpg",@"Mark_X_Camera_Frame_Face_04.jpg",@"Mark_X_Camera_Frame_Face_05.jpg",@"Mark_X_Camera_Frame_Face_06.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg"]
#define kCameraFrameBiBuArrayX     @[@"Mark_X_Camera_Frame_Nose_01.jpg",@"Mark_X_Camera_Frame_Nose_02.jpg",@"Mark_X_Camera_Frame_Nose_03.jpg",@"Mark_X_Camera_Frame_Nose_04.jpg",@"Mark_X_Camera_Frame_Nose_05.jpg",@"Mark_X_Camera_Frame_Nose_06.jpg",@"Mark_X_Camera_Frame_Nose_07.jpg",@"Mark_X_Camera_Frame_Nose_08.jpg",@"Mark_X_Camera_Frame_Nose_09.jpg",@"Mark_X_Camera_Frame_Nose_10.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg"]
#define kCameraFrameBiaoQingArrayX    @[@"Mark_X_Camera_Frame_Expression_01.jpg",@"Mark_X_Camera_Frame_Expression_02.jpg",@"Mark_X_Camera_Frame_Expression_03.jpg",@"Mark_X_Camera_Frame_Expression_04.jpg",@"Mark_X_Camera_Frame_Face_01.jpg",@"Mark_X_Camera_Frame_Face_02.jpg",@"Mark_X_Camera_Frame_Face_03.jpg",@"Mark_X_Camera_Frame_Face_04.jpg",@"Mark_X_Camera_Frame_Face_05.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg"]
#define kCameraFrameShenTiArrayX     @[@"Mark_X_Camera_Frame_Section_01.jpg",@"Mark_X_Camera_Frame_Section_02.jpg",@"Mark_X_Camera_Frame_Section_03.jpg",@"Mark_X_Camera_Frame_Section_04.jpg",@"Mark_X_Camera_Frame_Section_05.jpg",@"Mark_X_Camera_Frame_Section_06.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg"]
#define kCameraFrameXiongBuArrayX    @[@"Mark_X_Camera_Frame_Chest_01.jpg",@"Mark_X_Camera_Frame_Chest_02.jpg",@"Mark_X_Camera_Frame_Chest_03.jpg",@"Mark_X_Camera_Frame_Chest_04.jpg",@"Mark_X_Camera_Frame_Chest_05.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg"]
#define kCameraFrameZiDingYiArrayX    @[@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg",@"Mark_X_Camera_Frame_Custom.jpg"]


// 拍摄参照图组X
#define kCameraFrameTempImageArrayX @[kCameraFrameMianBuArrayX,kCameraFrameBiBuArrayX,kCameraFrameBiaoQingArrayX,kCameraFrameShenTiArrayX,kCameraFrameXiongBuArrayX,kCameraFrameZiDingYiArrayX]


// 个人资料 -- 既往病史/生理状况
#define kJWBSArray           @[@"无",@"肺炎",@"心脏病",@"阑尾炎",@"胆结石",@"高血压",@"糖尿病",@"肾结石",@"肝功能障碍"]
#define kJWBSIDArray         @[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]
#define kSLZKArray           @[@"正常",@"痛经",@"经期延后",@"怀孕",@"月经提早",@"月经不调",@"月经期"]
#define kSLZKIDArray         @[@"0",@"0",@"0",@"0",@"0",@"0",@"0"]

#endif /* AppCommon_h */
