//
//  HomeCollectionViewCell.h
//  EPJH
//
//  Created by Hans on 2019/11/4.
//  Copyright © 2019 Hans3D. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;

+(NSString *)cellID;

@end

NS_ASSUME_NONNULL_END
