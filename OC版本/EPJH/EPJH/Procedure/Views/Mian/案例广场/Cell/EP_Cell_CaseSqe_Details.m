//
//  EP_Cell_CaseSqe_Details.m
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Cell_CaseSqe_Details.h"

@implementation EP_Cell_CaseSqe_Details

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    NSString * imgURLStr = dataDic[@"imageUrl"];
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:imgURLStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.mainImageView.image = image;
    }];
    
    NSString *anc = dataDic[@"cate"];
    if ([anc isEqualToString:@"术前"]) {  self.flagImageView.image = [UIImage imageNamed:@"gallery_before"]; }
    if ([anc isEqualToString:@"术后"]) {  self.flagImageView.image = [UIImage imageNamed:@"gallery_after"];  }
    
}
 
- (IBAction)clickBtnAction:(id)sender { if (self.btnClickBlock) { self.btnClickBlock(self); } }

@end
