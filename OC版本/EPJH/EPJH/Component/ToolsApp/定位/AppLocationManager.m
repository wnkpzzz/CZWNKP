//
//  AppLocationManager.m
//  EPJH
//
//  Created by Hans on 2020/9/28.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "AppLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface AppLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation AppLocationManager

/** 类方法初始化 */
+ (void)getCityAndProvinceWithComplete{
    
    AppLocationManager * locationManager = [[AppLocationManager alloc] init];
}

#pragma mark - 懒加载

- (CLLocationManager *)locationManager{
    if (!_locationManager ) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];//获取访问权限。可以在info.plist里面填写给用户的请求信息
        [_locationManager startUpdatingLocation];//开始定位
    }
    return _locationManager;
}

//  定位失败弹出提示框,点击"打开定位"按钮,会打开系统的设置,提示打开定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
 
}

//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [self.locationManager stopUpdatingLocation];
    
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    //反编码
    WS(weakSelf);
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            
            CLPlacemark *placeMark = placemarks[0];
            NSDictionary *addressDic=placeMark.addressDictionary;   //地址的所有信息
            NSString *state=[addressDic objectForKey:@"State"]; //省。直辖市
            NSString *city=[addressDic objectForKey:@"City"];   //市  城市
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"]; //区
            NSString *street=[addressDic objectForKey:@"Street"];   //街道
            
            NSLog(@"%@=====%@-----%@=====%@===%@",addressDic,state,city,subLocality,street);
//            weakSelf.province = state;
//            weakSelf.city = city;
//            weakSelf.cityTextField.text = [NSString stringWithFormat:@"%@ %@",  weakSelf.province, weakSelf.city];
            
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
        
    }];
}

@end
