//
//  AppURL.h
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//


#ifndef AppURL_h
#define AppURL_h

#define KAppNetRequestWithShowLog(show) [AppNetRequest ShareAppNetRequestWithShowLog:show]

#define curlWith(url) [NSString stringWithFormat:@"%@%@",AppURL,url]

// 正式根地址
#define AppURL                    @"http://112.74.35.130:8080/app-admin"
// 测试根地址
#define AppURK                    @"http://192.168.16.7:8088/app-admin"

// 正式根地址
#define App3dURL                  @"http://39.108.187.58:8080"
// 测试根地址
#define App3dURK                  @"http://192.168.1.131:8090"

// ************* 登录注册 *************

// 登录
#define URL_Login_login           curlWith(@"/api/biz/ou/v1/partys/login.htm")
// 注册
#define URL_Login_register        curlWith(@"/api/biz/ou/v1/partys/add.htm")
// 找回密码
#define URL_Login_forgetPwd       curlWith(@"/api/biz/ou/v1/partys/updatePassWordNoLogin.htm")
// 修改密码
#define URL_Login_changePwd       curlWith(@"/api/biz/ou/v1/partys/newUpdatePwd.htm")
// 发送验证码
#define URL_Login_getCode         curlWith(@"/api/biz/gl/v1/smsHis/add.htm")
// 第三方登录
#define URL_Login_other           curlWith(@"/api/biz/ou/v1/partys/thirdLogin.htm")
// ************* 首页 *************

// 首页广告
#define URL_Home_getAd            curlWith(@"/api/biz/gl/v1/banners/lists.htm")
// 上传图片
#define URL_img_upload            curlWith(@"/api/biz/gl/upload/ajax.htm")

// ************* 3D扫描 *************

#define durlWith(url) [NSString stringWithFormat:@"%@%@",App3dURL,url]

// 头模列表
#define URL_3d_list               durlWith(@"/EX-PRO/ypjh/share/getFileInfos")
// 头模下载
#define URL_3d_download           durlWith(@"/EX-PRO/ypjh/share/download")
// 头模转发
#define URL_3d_resend             durlWith(@"/EX-PRO/ypjh/share/forward")
// 头模删除
#define URL_3d_delete             durlWith(@"/EX-PRO/ypjh/share/deleteFile")
// 头模广告
#define URL_3d_getAd              curlWith(@"/api/biz/gl/v1/banners/lists.htm")

// ************* 案例广场 *************

// 案例广告
#define URL_case_ad               curlWith(@"/api/biz/gl/caseBanner/v1/lists.htm")
// 案例列表
#define URL_case_list             curlWith(@"/api/biz/gl/case/v1/lists.htm")
// 收藏/取消
#define URL_case_collect          curlWith(@"/api/biz/gl/case/v1/collection.htm?")
// 收藏列表
#define URL_case_collectlist      curlWith(@"/api/biz/gl/case/v1/collection/getInfos.htm")
// 项目列表
#define URL_case_pro_list         curlWith(@"/api/biz/gl/v1/cates/listAll.htm")
// 品牌列表
#define URL_case_brand_list       curlWith(@"/api/biz/gl/v1/cates/listBrand.htm")

// ************* 手术百科 *************

// 部位内容列表
#define URL_bk_info_list          curlWith(@"/api/biz/gl/surgeryEncyclopedia/v1/lists.htm")

// ************* 个人中心 *************

// 用户信息
#define URL_User_info             curlWith(@"/api/biz/ou/v1/partys/get.htm")
// 保存个人资料
#define URL_User_save             curlWith(@"/api/biz/ou/v1/partys/update.htm")
// 意见反馈
#define URL_User_feedBack         curlWith(@"/api/ec/site/v1/suggestionEntitys/add.htm")
// 个人中心配置网页
#define URL_User_webView          curlWith(@"/api/biz/gl/v1/glConfigs/get.htm")
// 帮助中心 - 问题列表
#define URL_User_helplist         curlWith(@"/api/biz/gl/glHelpCenter/v1/lists.htm")
// 帮助中心 - 获取内容
#define URL_User_helpinfo         curlWith(@"/api/biz/gl/glHelpCenter/v1/get.htm")

// ************* 数据中心 *************

// 上传云端数据
#define URL_User_uploadYun        curlWith(@"/api/biz/ou/app/v1/partys/upload.htm")
// 获取云端数据
#define URL_User_yunData          curlWith(@"/api/biz/ou/app/v1/partys/getList.htm")
// 下载云端数据
#define URL_User_downYun          curlWith(@"/api/biz/ou/app/v1/partys/download.htm")
// 删除云端数据
#define URL_User_deleteYun        curlWith(@"/api/biz/ou/app/v1/partys/delete.htm")
// 资料发送共享
#define URL_User_share            curlWith(@"/api/biz/ou/app/v1/partys/sharing.htm")
// 消息列表
#define URL_User_msglist          curlWith(@"/api/biz/ou/share/v1/getList.htm")
// 删除消息
#define URL_User_deleteMsg        curlWith(@"/api/biz/ou/share/v1/delete.htm")
// 消息-确认接收
#define URL_User_okMsg            curlWith(@"/api/biz/ou/app/v1/shareDownload.htm")
// 消息个数
#define URL_User_msgNum           curlWith(@"/api/biz/ou/share/v1/getShareCount.htm")
// 消息转发
#define URL_Data_resend           curlWith(@"/api/biz/ou/share/v1/forward.htm")

// 内部上传
#define URL_data_upload           curlWith(@"/api/biz/ou/app/v1/partys/uploadLocal.htm")
// 上传+转发
#define URL_data_sendUpload       curlWith(@"/api/biz/ou/app/v1/partys/uploadAndShare.htm")
// 检测云端空间
#define URL_data_checkSpaceSize   curlWith(@"/api/biz/ou/app/v1/partys/isOutnumberMaxMemory.htm")

#endif /* AppURL_h */




