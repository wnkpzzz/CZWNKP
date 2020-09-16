
pod update --verbose --no-repo-update

// *************************   工程配置 *******************************
1.
大版本号 1.0
小版本号 1.0.0.0
重大版本更新，大版本+1，一般更新，大版本后缀+1
Xcode每次打包提交小版本号都要+1
2.
默认支持iOS11.0以上
3.
不支持横竖屏
4.
配置Pch文件路径
pchField.Pch -- Build Settings -- 搜索 Prefix Hedader -- $(SRCROOT)/EPJH/Config/pchField.pch
5.
删除SB布局文件,采用自定义布局.
6.
类方法命名采用首字母小写驼峰命名法
控制器类首字母大写，后缀ViewCtl TableViewCtl 类推。
图片资源全部png格式。
7. infoPlist
<key>NSCameraUsageDescription</key>
<string>App需要您的同意,才能访问相机</string>
<key>NSMicrophoneUsageDescription</key>
<string>App需要您的同意,才能访问麦克风</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>App需要您的同意,才能访问相册</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>App需要您的同意,才能在使用期间访问位置，以便提供服务。</string>
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>

