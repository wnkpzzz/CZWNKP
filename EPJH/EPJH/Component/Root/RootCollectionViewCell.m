//
//  RootCollectionViewCell.m
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "RootCollectionViewCell.h"

@implementation RootCollectionViewCell

+(NSString *)cellID{
    
    NSString * const ID = [NSString stringWithUTF8String:object_getClassName(self)];
    
    return ID;
}

@end
