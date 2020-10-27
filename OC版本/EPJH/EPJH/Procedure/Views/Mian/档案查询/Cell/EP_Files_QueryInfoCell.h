//
//  EP_Files_QueryInfoCell.h
//  EPJH
//
//  Created by Hans on 2020/10/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EP_Files_QueryInfoCell : RootTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *avatarImageButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *allnameLabel;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImage;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

NS_ASSUME_NONNULL_END
