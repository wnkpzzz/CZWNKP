//
//  EP_Cell_CaseSqe_Details.h
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EP_Cell_CaseSqe_Details : RootCollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property(nonatomic,strong) NSDictionary * dataDic;

@property (copy,nonatomic) void (^btnClickBlock)(UICollectionViewCell * cell);

@end

NS_ASSUME_NONNULL_END

