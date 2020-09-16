//
//  AppPhotoUtils.m
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "AppPhotoUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation AppPhotoUtils

/** 手机闪光灯控制打开/关闭 */
+ (void)controlClashlightWith:(BOOL)switchFlag{
     
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if (switchFlag) {
                [device setTorchMode:AVCaptureTorchModeOn];
            }else{
                [device setTorchMode:AVCaptureTorchModeOff];
            }
            [device unlockForConfiguration];
        }else{
            NSLog(@"初始化失败");
        }
    }else{
        NSLog(@"没有闪光设备");
    }
}

/** 对图片尺寸剪裁 */
+ (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size{
 
     CGSize originalsize = [originalImage size];

     //原图长宽均小于标准长宽的，不作处理返回原图
     if (originalsize.width<size.width && originalsize.height<size.height) { return originalImage;}

     //原图长宽均大于标准长宽的，按比例缩小至最大适应值
     else if(originalsize.width>size.width && originalsize.height>size.height){

         CGFloat rate = 1.0;
         CGFloat widthRate = originalsize.width/size.width;
         CGFloat heightRate = originalsize.height/size.height;
         rate = widthRate>heightRate?heightRate:widthRate;
         CGImageRef imageRef = nil;

         if (heightRate>widthRate){
            //获取图片整体部分
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));
         }else {
            //获取图片整体部分
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));
         }

         UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
         CGContextRef con = UIGraphicsGetCurrentContext();
         CGContextTranslateCTM(con, 0.0, size.height);
         CGContextScaleCTM(con, 1.0, -1.0);
         CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
         UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         CGImageRelease(imageRef);
         return standardImage;
     }

     //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
     else if(originalsize.height>size.height || originalsize.width>size.width){

         CGImageRef imageRef = nil;

         if(originalsize.height>size.height){
            //获取图片整体部分
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));

         }else if (originalsize.width>size.width){

            //获取图片整体部分
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));

         }

        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;

     }
   
    //原图为标准长宽的，不做处理
     else{  return originalImage; }
          
 
}
 
@end
