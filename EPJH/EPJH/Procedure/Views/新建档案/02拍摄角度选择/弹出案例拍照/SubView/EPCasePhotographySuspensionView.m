//
//  EPCasePhotographySuspensionView.m
//  EPJH
//
//  Created by Hans on 2020/8/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPCasePhotographySuspensionView.h"

@interface EPCasePhotographySuspensionView ()
  
@property (weak, nonatomic) IBOutlet UIButton *backBtn;/** 返回按钮 */
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;/** 完成并保存按钮 */

@property (weak, nonatomic) IBOutlet UIButton *albumBtn;/** 相册按钮 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn; /** 取消当前拍摄 */
@property (weak, nonatomic) IBOutlet UIButton *takeBtn; /** 拍照按钮 */
@property (weak, nonatomic) IBOutlet UIButton *nextBtn; /** 确认并进入下一张拍摄按钮 */

@property (weak, nonatomic) IBOutlet UIButton *skipBtn;/** 拍摄下一张按钮 */
@property (weak, nonatomic) IBOutlet UIButton *flashlightBtn;/** 手电筒按钮 */
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;/** 切换摄像头 */




 
@end

@implementation EPCasePhotographySuspensionView
 
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     
    [self loadBaseConfig];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{
    

   
}

#pragma mark - 事件处理
- (IBAction)btnClickAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
    }
}
    
- (void)setTakePicStatusType:(CaseTakePicStatusType)takePicStatusType{
    
    switch (self.takePicStatusType) {
       
        case CaseTakePicStatusTypeDefault:

            break;
        case CaseTakePicStatusTypeTakePic:

            break;
        default:
            break;
    }
}




@end
